import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BreathingCircle(),
      ),
    );
  }
}

class BreathingCircle extends StatefulWidget {
  @override
  _BreathingCircleState createState() => _BreathingCircleState();
}

class _BreathingCircleState extends State<BreathingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<dynamic> _animation;
  late CurvedAnimation _curve;
  List<int> repetitionOptions = [5,10,15,20,25,30,35,40];
  int _repetitions = 5;
  int _currentRepetitions = 0;
  int duration = 2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    _animation = Tween<dynamic>(begin: 100.0, end: 200.0).animate(_curve)..addStatusListener((status) {
      print(status);
        if (status == AnimationStatus.completed) {
          print('reverse loop $_currentRepetitions');
          if (_currentRepetitions < _repetitions - 1) {
            _controller.reverse();
            
          }
        } else if (status == AnimationStatus.dismissed) {
          print('forward loop $_currentRepetitions');
          if (_currentRepetitions < _repetitions - 1) {
            _currentRepetitions++;
            _controller.forward();
          }
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
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            height: _animation.value,
            width: _animation.value,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Column(children:[Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Text(
                (_currentRepetitions + 1).toString(),
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          )]),
          );
        },
      ),
    );
  }
}
