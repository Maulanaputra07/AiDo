import 'package:aido/firebase_options.dart';
import 'package:aido/pages/add_task.dart';
import 'package:aido/pages/auth/login_page.dart';
import 'package:aido/pages/auth/register_page.dart';
import 'package:aido/pages/home.dart';
import 'package:aido/pages/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './navigation/main_navigation.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null);
  runApp(
    ProviderScope(
      child: MyApp(),
    )
    );
}

class MyApp extends StatefulWidget{
  const MyApp ({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp>{
  @override
  void initState(){
    super.initState();
    initialization();
  }

  void initialization() async {
    // print("Pausing...");
    await Future.delayed(const Duration(seconds: 3));
    // print("Unpausing");
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFAFAFA)
      ),
      home: const WelcomePage(),
      routes: {
        '/main' : (context) => const MainNavigation(),
        '/addtask': (context) => const AddTaskPage(),
        '/welcome': (context) => const WelcomePage(),
        '/login' : (context) => const LoginPage(),
        '/register' : (context) => const RegisterPage(),
      },
    );
  }
}