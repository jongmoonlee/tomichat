// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map? _userData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title:
                Text('Facebook(Logged )' + (_userData == null ? 'out' : 'in'))),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text('Log In'),
                onPressed: () async {
                  final result = await FacebookAuth.i
                      .login(permissions: ["public_profile", "email"]);

                  if (result.status == LoginStatus.success) {
                    final requestData = await FacebookAuth.i.getUserData(
                      fields: "email, name",
                    );

                    setState(() {
                      _userData = requestData;
                    });
                  }
                },
              ),
              ElevatedButton(
                child: Text('Log Out'),
                onPressed: () async {
                  await FacebookAuth.i.logOut();

                  setState(() {
                    _userData = null;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
