import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1483C2), Color(0xFF1483C2), Color(0xFF1483C2), Color(0xFF1483C2), Color(0xFF9DCAE3), Color(0xFFFAFAFA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 300), 
                Image.asset(
                  'assets/icons/aidoWelcome.png',
                  width: 300,
                ),
                Text(
                  "Welcome to aido",
                  style: TextStyle(
                      color: Color(0xFFFAFAFA)
                    ),
                  ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1483C2),
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Color(0xFFFAFAFA),
                              fontSize: 25,
                              fontFamily: 'Instrument',
                              fontWeight: FontWeight.bold
                            )
                            ,)
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFAFAFA)
                          ),
                          child: const Text(
                            "Login", 
                            style: TextStyle(
                              fontFamily: 'Instrument',
                              fontSize: 25,
                              color: Color(0xFF1483C2),
                              fontWeight: FontWeight.bold
                            ),
                            )
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 100,)
              ],
            ),
          ),
      )
    );
  }
}