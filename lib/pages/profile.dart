import 'package:aido/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA), 
      ),
      body: userData.when(
        data: (user) => 
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
              padding: EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Instrument',
                      color: Color(0xFF1483C2),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Username : ${user.username}',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF1483C2),
                      fontFamily: 'Instrument',
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authRepositoryProvider).logout();
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
            )
            )
          ],
        ), 
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => Text('error : $err'), 
      )
    );
  }
}