import 'package:flutter/foundation.dart';
import 'enum_breathing_speed.dart';
import 'enum_session_status.dart';

class BreathworkSession extends ChangeNotifier {
  int _totalRepetitions = 30;
  int _noOfRounds = 3;
  BreathingSpeed _breathingSpeed = BreathingSpeed.medium;
  late SessionStatus _status = SessionStatus.options;
  List<int> _breathholdDurations = [];

  int get totalRepetitions => _totalRepetitions;
  BreathingSpeed get breathingSpeed => _breathingSpeed;
  List<int> get breathholdDurations => _breathholdDurations;
  int get noOfRounds => _noOfRounds;
  SessionStatus get status => _status;

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

  set status(SessionStatus newStatus) {
    print('set status: $newStatus');
    _status = newStatus;
    notifyListeners();
  }

  set breathholdDurations(List<int> durations) {
    print('set breathholdDurations: $durations');
    _breathholdDurations = durations;
    notifyListeners();
  }
}
