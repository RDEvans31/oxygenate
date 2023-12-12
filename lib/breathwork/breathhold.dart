import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/state_breathwork_session.dart';
import 'package:provider/provider.dart';

import 'breathwork.dart';
import 'enum_session_status.dart';

class BreathHold extends StatefulWidget {
  const BreathHold({Key? key}) : super(key: key);

  @override
  _BreathHoldState createState() => _BreathHoldState();
}

class _BreathHoldState extends State<BreathHold> {
  final _stopwatch = Stopwatch();
  late Timer _timer;
  int elapsedMilliseconds = 0;

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        elapsedMilliseconds = _stopwatch.elapsedMilliseconds;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
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
                  height: 300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text((elapsedMilliseconds.toDouble() / 1000).toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _stopwatch.stop();
                        _timer.cancel();
                        breathworkSession.breathholdDurations =
                            breathworkSession.breathholdDurations +
                                [
                                  _stopwatch.elapsedMilliseconds.toDouble() /
                                      1000
                                ];
                        _stopwatch.reset();
                        if (breathworkSession.breathholdDurations.length ==
                            breathworkSession.noOfRounds) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Breathwork(
                                sessionStatus: SessionStatus.finished,
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Breathwork(
                                sessionStatus: SessionStatus.breathing,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Stop'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
