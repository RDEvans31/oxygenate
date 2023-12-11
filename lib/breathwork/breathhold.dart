import 'dart:async';

import 'package:flutter/material.dart';

class BreathHold extends StatefulWidget {
  const BreathHold({Key? key}) : super(key: key);

  @override
  _BreathHoldState createState() => _BreathHoldState();
}

class _BreathHoldState extends State<BreathHold> {
  final _stopwatch = Stopwatch();
  int _elapsedTime = 0;
  late Timer _timer;

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), _updateTime);
  }

  void _updateTime(timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _elapsedTime = _stopwatch.elapsedMilliseconds;
      });
    }
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer.cancel();
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const Breathwork(
    //       sessionStatus: SessionStatus.breathing,
    //     ),
    //   ),
    // );
  }

  void _resetTimer() {
    _stopTimer();
    _stopwatch.reset();
    setState(() {
      _elapsedTime = 0;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(_elapsedTime.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 24)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
