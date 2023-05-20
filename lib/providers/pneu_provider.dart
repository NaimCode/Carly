import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Position {
  frontLeft,
  frontRight,
  rearLeft,
  rearRight,
}

class Pneu {
  int temperature;
  double pressure;

  Pneu({required this.temperature, required this.pressure});
}

final pneusProvider = Provider((ref) => [
      Pneu(temperature: 38, pressure: 2.0),
      Pneu(temperature: 47, pressure: 2.5),
      Pneu(temperature: 40, pressure: 2.5),
      Pneu(temperature: 49, pressure: 1.5),
    ]);
