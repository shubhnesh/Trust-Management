import 'package:flutter/material.dart';
import 'package:manage_trust/presentation/screens/common/login_screen.dart';
import 'package:manage_trust/presentation/screens/common/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Government Trust Management System',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: LoginScreen(),
      initialRoute: '/login', // Start with the login screen
      routes: {
        '/login': (context) => LoginScreen(), // Login screen route
        '/signup': (context) => SignupScreen(), // Signup screen route
      },
    );
  }
}
