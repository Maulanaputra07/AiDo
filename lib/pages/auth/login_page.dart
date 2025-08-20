import 'package:aido/providers/auth_provider.dart';
import 'package:aido/repositories/auth_repositori.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>{
  bool _isLoading = false;
  bool isObscured = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    authRepository = ref.read(authRepositoryProvider);
  }

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
                child: Image.asset(
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
                ),
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
                    topRight: Radius.circular(32)
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
                          "Login",
                          style: TextStyle(
                            fontFamily: 'Instrument',
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xFF333333)
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
                      SizedBox(height: 19,),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: 'Instrument',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF333333),
                        ),
                      ),
                      TextField(
                        obscureText: isObscured,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isObscured = !isObscured;
                              });
                            }, 
                            icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility)
                          ),
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
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1483C2)
                          ),
                          child: _isLoading ? 
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ) 
                          : const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: 'Instrument',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFAFAFA)
                            ),
                          )
                          ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () async {
                            try{
                              final UserCredential = authRepository.signInWithGoogle();
                                if(context.mounted){
                                  Navigator.pushReplacementNamed(context, '/main');
                                }
                            } catch (e) {
                              print("error $e");
                            }
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/google.png',
                                height: 24,
                              ),
                              const SizedBox(width: 12,),
                              const Text(
                                "Login with google",
                                style: TextStyle(
                                  fontFamily: 'Instrument',
                                  fontSize: 25,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try{
    final user = await authRepository.login(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim()
    );

    if(user != null){
      // await authRepository.saveLoginData(token)
      Navigator.pushReplacementNamed(context, '/main');
    }

    }catch (e) {
        AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: "Error",
        desc: e.toString(),
        btnOkOnPress: () {},
        btnOkText: "Oke",
        btnOkColor: Color(0xFF1483C2)
      ).show();
    } finally{
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}