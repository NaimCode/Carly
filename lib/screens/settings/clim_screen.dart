import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/car.dart';

class TempNotifier extends StateNotifier<int> {
  TempNotifier() : super(26);

  void increment() => state++;
  void decrement() => state--;
}

final tempProvider = StateNotifierProvider<TempNotifier, int>((ref) {
  return TempNotifier();
});

class ClimScreen extends HookConsumerWidget {
  const ClimScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temp = ref.watch(tempProvider);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Current temperature",
                  style: TextStyle(color: Colors.blue.shade200),
                ),
                const SizedBox(height: 20),
                IconButton.outlined(
                    onPressed: () {
                      ref.read(tempProvider.notifier).increment();
                    },
                    icon: const Icon(Icons.arrow_upward)),
                const SizedBox(height: 10),
                Text('$temp°C',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 10),
                IconButton.outlined(
                    onPressed: () {
                      ref.read(tempProvider.notifier).decrement();
                    },
                    icon: const Icon(Icons.arrow_downward)),
              ],
            )),
            const Expanded(child: Car())
          ],
        )));
  }
}
