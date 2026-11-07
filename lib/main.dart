import 'package:flutter/material.dart';
import 'flutter/screen_logic.dart'; // <--- 1. هنا بتستورد ملف الشاشة الجديدة (اكتب مساره صح)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rattan App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenLogic(), // <--- 2. هنا بتحط اسم الكلاس بتاع الشاشة الجديدة
    );
  }
}