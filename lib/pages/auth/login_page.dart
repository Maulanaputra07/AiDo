import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("ini login Page"),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              }, 
              child: const Text("Login")
            ),
        ],
      ),
    );
  }
}