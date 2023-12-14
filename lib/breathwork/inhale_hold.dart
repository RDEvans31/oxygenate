import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oxygenate/breathwork/state_breathwork_session.dart';

import 'breathwork.dart';
import 'enum_session_status.dart';

class InhaleHold extends StatefulWidget {
  final BreathworkSession breathworkSession;
  const InhaleHold({Key? key, required this.breathworkSession})
      : super(key: key);

  @override
  _InhaleHoldState createState() => _InhaleHoldState();
}

class _InhaleHoldState extends State<InhaleHold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _countdown = 15;
  String _displayTime = '00:15';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    _animation = Tween<double>(begin: 70.0, end: 200.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
            if (_countdown < 1) {
              _timer.cancel();
              if (widget.breathworkSession.breathholdDurations.length ==
                  widget.breathworkSession.noOfRounds) {
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
            } else {
              setState(() {
                _countdown--;
                _displayTime =
                    _countdown > 9 ? '00:$_countdown' : '00:0$_countdown';
              });
            }
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: _animation.value,
                          width: _animation.value,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                            _animation.isCompleted
                                ? _displayTime.toString()
                                : 'Inhale',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 24))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
      ),
    );
  }
}
