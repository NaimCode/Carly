import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/car.dart';

class DoorsNotifier extends StateNotifier<List<bool>> {
  DoorsNotifier() : super([false, true, true, true]);

  void openClose(int index) {
    state[index] = !state[index];
    state = [...state];
  }
}

final doorsProvider = StateNotifierProvider<DoorsNotifier, List<bool>>((ref) {
  return DoorsNotifier();
});

class PortesScreen extends HookConsumerWidget {
  const PortesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doors = ref.watch(doorsProvider);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            const Car(),
            Column(
              children: [
                Expanded(
                    child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: IconButton.filled(
                        style: IconButton.styleFrom(
                            backgroundColor: doors[0] ? null : Colors.red),
                        onPressed: () {
                          ref.read(doorsProvider.notifier).openClose(0);
                        },
                        icon: Icon(
                          !doors[0] ? Icons.lock_open : Icons.lock_outline,
                        )),
                  ),
                )),
                Row(
                  children: [
                    Expanded(
                        child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: IconButton.filled(
                            style: IconButton.styleFrom(
                                backgroundColor: doors[1] ? null : Colors.red),
                            onPressed: () {
                              ref.read(doorsProvider.notifier).openClose(1);
                            },
                            icon: Icon(
                              !doors[1] ? Icons.lock_open : Icons.lock_outline,
                            )),
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: IconButton.filled(
                            style: IconButton.styleFrom(
                                backgroundColor: doors[2] ? null : Colors.red),
                            onPressed: () {
                              ref.read(doorsProvider.notifier).openClose(2);
                            },
                            icon: Icon(
                              !doors[2] ? Icons.lock_open : Icons.lock_outline,
                            )),
                      ),
                    )),
                  ],
                ),
                Expanded(
                    child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: IconButton.filled(
                        style: IconButton.styleFrom(
                            backgroundColor: doors[3] ? null : Colors.red),
                        onPressed: () {
                          ref.read(doorsProvider.notifier).openClose(3);
                        },
                        icon: Icon(
                          !doors[3] ? Icons.lock_open : Icons.lock_outline,
                        )),
                  ),
                )),
              ],
            )
          ],
        )));
  }
}
