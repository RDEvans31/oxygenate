import 'package:flutter/material.dart';

class Breathing extends StatefulWidget {
  final int durationInMilliseconds;
  final int totalRepetitions;

  const Breathing(
      {super.key,
      required this.durationInMilliseconds,
      required this.totalRepetitions});

  @override
  _BreathingState createState() => _BreathingState();
}

class _BreathingState extends State<Breathing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentRepetition = 1;

  startBreathwork() {
    setState(() => _currentRepetition = 1);
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMilliseconds),
    );

    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    _animation = Tween<double>(begin: 100.0, end: 200.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed &&
            _currentRepetition < widget.totalRepetitions) {
          _currentRepetition++;
          _controller.forward();
        } else if (_currentRepetition == widget.totalRepetitions &&
            status == AnimationStatus.dismissed) {
          _controller.stop();
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const Breathwork(
          //       sessionStatus: SessionStatus.breathhold,
          //     ),
          //   ),
          // );
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        _currentRepetition.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
