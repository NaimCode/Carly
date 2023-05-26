import 'package:hooks_riverpod/hooks_riverpod.dart';

class SiegeNotifier extends StateNotifier<Map<String, double>> {
  SiegeNotifier() : super({"horizontal": 0.0, "vertical": 0.0});

  void change(String key, double value) {
    state = {...state, key: value};
  }
}

final siegeProvider = StateNotifierProvider<SiegeNotifier, Map<String, double>>(
    (ref) => SiegeNotifier());
