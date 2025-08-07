import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscrued = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 200),
                // mainAxisAlignment: MainAxisAlignment.center,
                child:
                  Image.asset(
                    'assets/icons/aidoWelcome.png',
                    width: 300,
                  ),
              ),
            ),

            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.5,
              left: 16,
              child: Opacity(
                opacity: 1,
                child: Transform.rotate(
                  angle: 0.2,
                  child: Image.asset(
                    'assets/icons/oc-taking-note.png',
                    width: 200,
                  ),
                )
              ),
            ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.55,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  )
                ),
                padding: const EdgeInsets.all(24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Instrument',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontFamily: 'Instrument',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        fontSize: 20
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        // labelText: "Email",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFF333333),
                        //   fontWeight: FontWeight.bold,
                        //   fontFamily: 'Instrument',
                        //   fontSize: 25
                        // ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)
                        ), 
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Username",
                      style: TextStyle(
                        fontFamily: 'Instrument',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        fontSize: 20
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        // labelText: "Email",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFF333333),
                        //   fontWeight: FontWeight.bold,
                        //   fontFamily: 'Instrument',
                        //   fontSize: 25
                        // ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)
                        ), 
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontFamily: 'Instrument',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                        fontSize: 20
                      ),
                    ),
                    TextField(
                      obscureText: isObscrued,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        suffixIcon: IconButton(
                          icon: Icon(isObscrued ? Icons.visibility_off : Icons.visibility),
                          onPressed: (){
                            setState(() {
                              isObscrued = !isObscrued;
                            });
                          }, 
                          ),
                        // labelText: "Email",
                        // labelStyle: TextStyle(
                        //   color: Color(0xFF333333),
                        //   fontWeight: FontWeight.bold,
                        //   fontFamily: 'Instrument',
                        //   fontSize: 25
                        // ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)
                        ), 
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)
                        )
                      ),
                    ),
                    SizedBox(height: 40,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1483C2)
                        ),
                        child: const Text(
                          "Register", 
                          style: TextStyle(
                            fontFamily: 'Instrument',
                            fontSize: 25,
                            color: Color(0xFFFAFAFA),
                            fontWeight: FontWeight.bold
                          ),
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/google.png',
                              height: 24,
                            ),
                            const SizedBox(width: 12,),
                            const Text(
                              "Continue with google", 
                              style: TextStyle(
                                fontFamily: 'Instrument',
                                fontSize: 25,
                                color: Color(0xFF333333),
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ]
                          )
                      ),
                    )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}