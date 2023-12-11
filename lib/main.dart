import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/breathwork.dart';
import 'package:oxygenate/breathwork/enum_session_status.dart';
import 'package:oxygenate/breathwork/state_breathwork_session.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BreathworkSession(),
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.amber,
              brightness: Brightness.dark,
            )),
        home: const Breathwork(
          sessionStatus: SessionStatus.options,
        ),
      ),
    );
  }
}
