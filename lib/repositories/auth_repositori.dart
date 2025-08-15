import 'package:aido/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/transformers.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _initialized = false;

  AuthRepository(this._auth, this._firestore);

  Future<void> _initialize() async {
    if(!_initialized){
      await _googleSignIn.initialize();
      _initialized = true;
    }
  }

  Future<UserModel?> register({
    required String email,
    required String username,
    required String password
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      final uid = credential.user!.uid;

      UserModel user = UserModel(
        uid: uid, 
        email: email, 
        username: username
      );

      await _firestore.collection('users').doc(uid).set(user.toMap());

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {

    await _initialize();
    await _googleSignIn.initialize();

    await _googleSignIn.attemptLightweightAuthentication();

    GoogleSignInAccount? googleUser;

    try{
      if(GoogleSignIn.instance.supportsAuthenticate()){
        googleUser = await _googleSignIn.authenticate();
      }
    } catch (e) {
      print("Google sign-in failed: $e");
      log("Google sign-in failed: $e");
      return null;
    }

    if (googleUser == null) return null;

    final auth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
    );

    // print("=== Google Credential ===");
    // print("ID Token: ${auth.idToken}");

    final cred = await FirebaseAuth.instance.signInWithCredential(credential);

    print("==== Firebase User ===");
    print("UID: ${cred.user?.uid}");
    print("Display Name: ${cred.user?.displayName}");
    print("Email: ${cred.user?.email}");
    print("Photo URL: ${cred.user?.photoURL}");

    final user = cred.user;
    if(user != null){
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      final docSnap = await docRef.get();
      if (!docSnap.exists){
        await docRef.set({
          "uid" : user.uid,
          "username" : user.displayName ?? "Guest",
          "email" : user.email,
        });
      }
    }

    return cred;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
        );

      final uid = credential.user!.uid;
      final snapshot = await _firestore.collection('users').doc(uid).get();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', uid);
      await prefs.setString('email', credential.user!.email ?? '');

      if(snapshot.exists && snapshot.data() != null){
        return UserModel.formMap(snapshot.data()!);
      }else{
        throw Exception('Data pengguna tidak ditemukan');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseAuthError(e));
    }catch (e) {
      rethrow;
    }
  }

  Future<void> logout(WidgetRef ref) async {
    print("==== LOGOUT ====");
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _auth.signOut();
    await _googleSignIn.signOut();

    ref.invalidate(userProvider);
  }

  Future<void> saveLoginData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('token', token);
  }

  Stream<UserModel?> get userStream {
    print("=== userStream dipanggil ===");

    return _auth.authStateChanges().switchMap((user) {
      if(user == null){
        print(" ==== Belum login, return null stream");
        return Stream.value(null);
      }

      print("==== UID: ${user.uid} ====");

      
      return _firestore
      .collection('users')
      .doc(user.uid)
      .snapshots()
      .map((doc) {
        print("Firestore data: ${doc.data()}");
        return UserModel.formMap(doc.data()!);
      });
      // .map((doc) => UserModel.formMap(doc.data()!));
    });
  }

  Future<void> updateUsername(String newUsername) async {
    final uid = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(uid).update({
      'username' : newUsername
    });
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Format email tidak valid';
      case 'user-disabled':
        return 'Akun anda di nonaktifkan';
      case 'user-not-found':
        return 'Email tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      default:
        return 'Terjadi kesalahan: ${e.message}';
    }
  }
}