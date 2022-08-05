import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Users?> readUser() async {
    final docUsers = FirebaseFirestore.instance.collection('users');
    final snapshot = await docUsers.doc('cKbnGh9mkGaIlhCpl9Hn').get();

    if (snapshot.exists) {
      return Users.fromJson(snapshot.data()!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    const darkBackgroundColor = Color(0xFF2E3239);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: darkBackgroundColor),
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        drawer: Drawer(
          backgroundColor: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: FutureBuilder<Users?>(
                  future: readUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Ocorreu um erro'));
                    } else if (snapshot.hasData) {
                      final user = snapshot.data;
                      return Center(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Olá, ${user!.username}',
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: darkBackgroundColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          subtitle: Center(
                            child: Text(
                              user.email ?? '',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: darkBackgroundColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black54,
                        ),
                      );
                    }
                  },
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Sair',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class Users {
  String id;
  String? username;
  String? email;

  Users({this.username, this.email, this.id = ''});

  Map<String, dynamic> toJson() =>
      {'id': id, 'username': username, 'email': email};

  static Users fromJson(Map<String, dynamic> json) =>
      Users(id: json['id'], username: json['username'], email: json['email']);
}
