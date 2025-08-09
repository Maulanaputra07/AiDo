import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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

      await _fireStore.collection('users').doc(uid).set(user.toMap());

      return user;
    } catch (e) {
      rethrow;
    }
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
      final snapshot = await _fireStore.collection('users').doc(uid).get();

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

  Future<void> saveLoginData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('token', token);
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