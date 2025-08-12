import 'package:aido/navigation/main_navigation.dart';
import 'package:aido/pages/home.dart';
import 'package:aido/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasData){
          return const MainNavigation();
        }else{
          return const WelcomePage();
        }
      }
    );
  }
}