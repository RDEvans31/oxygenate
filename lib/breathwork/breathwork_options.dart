import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'breathwork.dart';
import 'enum_breathing_speed.dart';
import 'enum_session_status.dart';
import 'state_breathwork_session.dart';

class BreathworkOptions extends StatefulWidget {
  const BreathworkOptions({super.key});

  @override
  _BreathworkOptionsState createState() => _BreathworkOptionsState();
}

class _BreathworkOptionsState extends State<BreathworkOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BreathworkSession>(
        builder: (context, breathworkSession, child) {
      return Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                width: 300,
                child: Slider(
                  value: breathworkSession.noOfRounds.toDouble(),
                  onChanged: (value) {
                    breathworkSession.noOfRounds = value.toInt();
                  },
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: breathworkSession.noOfRounds.toString(),
                )),
            SizedBox(
              width: 350,
              child: SegmentedButton(
                  segments: const [
                    ButtonSegment(
                        value: BreathingSpeed.slow, label: Text('Slow')),
                    ButtonSegment(
                        value: BreathingSpeed.medium, label: Text('Normal')),
                    ButtonSegment(
                        value: BreathingSpeed.fast, label: Text('Fast')),
                  ],
                  selected: {
                    breathworkSession.breathingSpeed,
                  },
                  onSelectionChanged: (value) {
                    breathworkSession.breathingSpeed = value.first;
                  }),
            ),
            SizedBox(
                height: 100,
                width: 300,
                child: Slider(
                  value: breathworkSession.totalRepetitions.toDouble(),
                  onChanged: (value) {
                    breathworkSession.totalRepetitions = value.toInt();
                  },
                  min: 5,
                  max: 40,
                  divisions: 7,
                  label: breathworkSession.totalRepetitions.toString(),
                )),
            ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Breathwork(
                          sessionStatus: SessionStatus.breathing,
                        ),
                      ),
                    ),
                child: const Text('Start'))
          ],
        ),
      ));
    });
  }
}
