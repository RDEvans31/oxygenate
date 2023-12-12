import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/breathwork_options.dart';
import 'breathhold.dart';
import 'breathing.dart';
import 'package:provider/provider.dart';
import 'enum_breathing_speed.dart';
import 'enum_session_status.dart';
import 'state_breathwork_session.dart';

class Breathwork extends StatefulWidget {
  final SessionStatus? sessionStatus;

  const Breathwork({super.key, this.sessionStatus});

  @override
  _BreathworkState createState() => _BreathworkState();
}

class _BreathworkState extends State<Breathwork> {
  late SessionStatus? status;

  int getDurationInMilliseconds(BreathingSpeed speed) {
    switch (speed) {
      case BreathingSpeed.slow:
        return 2000;
      case BreathingSpeed.medium:
        return 1600;
      case BreathingSpeed.fast:
        return 1200;
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.sessionStatus);
    status = widget.sessionStatus ?? SessionStatus.options;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BreathworkSession>(
        builder: (context, breathworkSession, child) {
      return Scaffold(body: Builder(builder: (context) {
        switch (status) {
          case SessionStatus.options:
            return BreathworkOptions(
              key: UniqueKey(),
            );
          case SessionStatus.breathing:
            return Breathing(
              key: UniqueKey(),
              durationInMilliseconds:
                  getDurationInMilliseconds(breathworkSession.breathingSpeed),
              totalRepetitions: breathworkSession.totalRepetitions,
            );
          case SessionStatus.breathhold:
            return BreathHold(key: UniqueKey());
          case SessionStatus.finished:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Finished!'),
                  ElevatedButton(
                      onPressed: () {
                        breathworkSession.reset();
                        setState(() {
                          status = SessionStatus.options;
                        });
                      },
                      child: const Text('Restart')),
                  Text(
                      'Breathhold durations: ${breathworkSession.breathholdDurations}'),
                ],
              ),
            );
          case null:
            return Container();
        }
      }));
    });
  }
}
