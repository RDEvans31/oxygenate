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
  final List<int> _repetitionOptions = [2, 20, 30, 40];
  int _totalRepetitions = 1;
  BreathingSpeed _breathingSpeed = BreathingSpeed.medium;
  late SessionStatus status;

  void setTotalRepetitions(int repetitions) {
    setState(() {
      _totalRepetitions = repetitions;
    });
  }

  void setStatus(SessionStatus newStatus) {
    setState(() {
      status = newStatus;
    });
  }

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

  void setBreathingSpeed(selectedSpeed) {
    setState(() {
      _breathingSpeed = selectedSpeed;
    });
  }

  @override
  void initState() {
    super.initState();
    status = widget.sessionStatus ?? SessionStatus.options;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BreathworkSession(),
        child: Consumer<BreathworkSession>(
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
                      getDurationInMilliseconds(_breathingSpeed),
                  totalRepetitions: _totalRepetitions,
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
                            setStatus(SessionStatus.options);
                          },
                          child: const Text('Restart'))
                    ],
                  ),
                );
            }
            ;
          }));
        }));
  }
}
