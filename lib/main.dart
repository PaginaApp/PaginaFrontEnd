import 'package:flutter/material.dart';
import 'package:projeto_pagina/telas/splash_art.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashArt(),
      debugShowCheckedModeBanner: false,
    );
  }
}
