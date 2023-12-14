import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/inhale_hold.dart';
import 'package:oxygenate/breathwork/state_breathwork_session.dart';
import 'package:provider/provider.dart';

import 'helpers/format_duration_to_string.dart';

class BreathHold extends StatefulWidget {
  const BreathHold({Key? key}) : super(key: key);

  @override
  _BreathHoldState createState() => _BreathHoldState();
}

class _BreathHoldState extends State<BreathHold> {
  final _stopwatch = Stopwatch();
  late Timer _timer;
  String elapsedTime = '00:00';

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        elapsedTime = formatDisplayTime(_stopwatch.elapsed);
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
                      Text(elapsedTime,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24)),
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
                        breathworkSession.breathholdDurations =
                            breathworkSession.breathholdDurations +
                                [_stopwatch.elapsed];
                        _stopwatch.reset();
                        _timer.cancel();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => InhaleHold(
                                  breathworkSession: breathworkSession)),
                        );
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
