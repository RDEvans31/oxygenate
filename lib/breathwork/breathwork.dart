import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/breathwork_options.dart';
import 'package:oxygenate/breathwork/helpers/format_duration_to_string.dart';
import 'package:oxygenate/breathwork/inhale_hold.dart';
import 'breathhold.dart';
import 'breathing.dart';
import 'package:provider/provider.dart';
import 'enum_breathing_speed.dart';
import 'enum_session_status.dart';
import 'state_breathwork_session.dart';

class Breathwork extends StatefulWidget {
  final SessionStatus? sessionStatus;
  const Breathwork({Key? key, this.sessionStatus}) : super(key: key);

  @override
  State<Breathwork> createState() => _BreathworkState();
}

class _BreathworkState extends State<Breathwork> {
  late SessionStatus status;
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
    if (widget.sessionStatus != null) {
      status = widget.sessionStatus!;
    } else {
      status = SessionStatus.options;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BreathworkSession>(
      builder: (context, breathworkSession, child) {
        switch (status) {
          case SessionStatus.options:
            return const BreathworkOptions();
          case SessionStatus.breathing:
            return Breathing(
              durationInMilliseconds:
                  getDurationInMilliseconds(breathworkSession.breathingSpeed),
              totalRepetitions: breathworkSession.totalRepetitions,
            );
          case SessionStatus.breathhold:
            return const BreathHold();
          case SessionStatus.inhaleHold:
            return InhaleHold(breathworkSession: breathworkSession);
          case SessionStatus.finished:
            List<String> breathworkDurationStrings = breathworkSession
                .breathholdDurations
                .map((Duration duration) => formatDisplayTime(duration))
                .toList();
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Finished!'),
                    Text('Breathhold durations: $breathworkDurationStrings'),
                    ElevatedButton(
                      onPressed: () {
                        breathworkSession.reset();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Breathwork(
                              sessionStatus: SessionStatus.options,
                            ),
                          ),
                        );
                      },
                      child: const Text('Restart'),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const BreathworkOptions();
        }
      },
    );
  }
}
