import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
          child: Text('Você está logado com: ${currentUser.currentUser!.email}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentUser.signOut();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
