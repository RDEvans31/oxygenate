import 'package:flutter/foundation.dart';
import 'enum_breathing_speed.dart';

class BreathworkSession extends ChangeNotifier {
  late int _totalRepetitions = 5;
  late int _noOfRounds = 3;
  BreathingSpeed _breathingSpeed = BreathingSpeed.medium;
  List<Duration> _breathholdDurations = [];

  int get totalRepetitions => _totalRepetitions;
  BreathingSpeed get breathingSpeed => _breathingSpeed;
  List<Duration> get breathholdDurations => _breathholdDurations;
  int get noOfRounds => _noOfRounds;

  void reset() {
    _totalRepetitions = 5;
    _noOfRounds = 3;
    _breathingSpeed = BreathingSpeed.medium;
    _breathholdDurations = [];
  }

  set totalRepetitions(int repetitions) {
    _totalRepetitions = repetitions;
    notifyListeners();
  }

  set noOfRounds(int rounds) {
    _noOfRounds = rounds;
    notifyListeners();
  }

  set breathingSpeed(BreathingSpeed speed) {
    _breathingSpeed = speed;
    notifyListeners();
  }

  set breathholdDurations(List<Duration> durations) {
    _breathholdDurations = durations;
    notifyListeners();
  }
}
