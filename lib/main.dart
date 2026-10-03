import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const FoodoraXApp());
}

class FoodoraXApp extends StatelessWidget {
  const FoodoraXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodoraX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}