import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/breathwork.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.tealAccent,
              brightness: Brightness.dark,
              background: const Color.fromRGBO(50, 50, 50, 1)),
        ),
        home: const Breathwork());
  }
}
