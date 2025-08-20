import 'package:aido/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

class ProfilePage extends ConsumerWidget {
  const ProfilePage ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);
    log("ProfilePage dibuka");
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA), 
        automaticallyImplyLeading: false,
      ),
      body: 
      userData.when(
        data: (user) => 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(17),
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Instrument',
                  color: Color(0xFF1483C2),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Username: ",
                          style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF1483C2),
                          fontFamily: 'Instrument',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        user?.username ?? "Guest",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF1483C2),
                          fontFamily: 'Instrument',
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Email: ",
                          style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF1483C2),
                          fontFamily: 'Instrument',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5,),
                      FittedBox(
                        child: Text(
                          user?.email ?? "-",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF1483C2),
                            fontFamily: 'Instrument',
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authRepositoryProvider).logout(ref);
                      if(context.mounted){
                        Navigator.pushReplacementNamed(context, '/welcome');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1483C2)
                    ), 
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Color(0xFFFAFAFA),
                        fontSize: 20,
                      ),
                    )
                  )
                ],
              ),
              ),
            ),
          ],
        ), 
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => Text('error : $err'), 
      )
    );
  }
}