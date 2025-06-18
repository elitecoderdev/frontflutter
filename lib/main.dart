// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/screens/login_screen.dart';

Future<void> main() async {
  await dotenv.load(); // reads .env
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prescription History',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginScreen(),
    );
  }
}
