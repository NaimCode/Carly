import 'package:hooks_riverpod/hooks_riverpod.dart';

class FenetreNotifier extends StateNotifier<Map<String, double>> {
  FenetreNotifier() : super({"vertical": 0.0});

  void changeVertical(double value) {
    state = {...state, "vertical": value};
  }
}

final fenetreProvider =
    StateNotifierProvider<FenetreNotifier, Map<String, double>>(
        (ref) => FenetreNotifier());
