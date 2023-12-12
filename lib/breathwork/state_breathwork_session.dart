import 'package:flutter/foundation.dart';
import 'enum_breathing_speed.dart';

class BreathworkSession extends ChangeNotifier {
  late int _totalRepetitions = 30;
  late int _noOfRounds = 3;
  BreathingSpeed _breathingSpeed = BreathingSpeed.medium;
  List<double> _breathholdDurations = [];

  int get totalRepetitions => _totalRepetitions;
  BreathingSpeed get breathingSpeed => _breathingSpeed;
  List<double> get breathholdDurations => _breathholdDurations;
  int get noOfRounds => _noOfRounds;

  void reset() {
    _totalRepetitions = 30;
    _noOfRounds = 3;
    _breathingSpeed = BreathingSpeed.medium;
    _breathholdDurations = [];
    notifyListeners();
  }

  set totalRepetitions(int repetitions) {
    print('set totalRepetitions: $repetitions');
    _totalRepetitions = repetitions;
    notifyListeners();
  }

  set noOfRounds(int rounds) {
    print('set totalRounds: $rounds');
    _noOfRounds = rounds;
    notifyListeners();
  }

  set breathingSpeed(BreathingSpeed speed) {
    print('set breathingSpeed: $speed');
    _breathingSpeed = speed;
    notifyListeners();
  }

  set breathholdDurations(List<double> durations) {
    print('set breathholdDurations: $durations');
    _breathholdDurations = durations;
    notifyListeners();
  }
}
