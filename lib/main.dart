import 'package:aido/firebase_options.dart';
import 'package:aido/pages/add_task.dart';
import 'package:aido/pages/auth/login_page.dart';
import 'package:aido/pages/auth/register_page.dart';
import 'package:aido/pages/auth_wrapper.dart';
// import 'package:aido/pages/home.dart';
import 'package:aido/pages/welcome/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './navigation/main_navigation.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting('id_ID', null);

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // final prefs = await SharedPreferences.getInstance();
  // final String? uid = prefs.getString('uid');
  // final IsLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  FlutterNativeSplash.remove();

  // WidgetsFlutterBinding.ensureInitialized();

  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if(user != null){
  //     print("User: ${user.email}");
  //   }else{
  //     print("belum login");
  //   }
  // });

  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
    )
    );
}

class MyApp extends StatelessWidget{
  // final bool isLoggedIn;
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFAFAFA)
      ),
      home: const AuthWrapper(),
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

// final authStateProvider = StreamProvider<User?>((ref) {
//   return FirebaseAuth.instance.authStateChanges();
// });
// class _MyAppState extends State<MyApp>{
//   @override
//   void initState(){
//     super.initState();
//     initialization();
//   }

//   void initialization() async {
//     // print("Pausing...");
//     await Future.delayed(const Duration(seconds: 3));
//     // print("Unpausing");
//     FlutterNativeSplash.remove();
//   }

  
// }