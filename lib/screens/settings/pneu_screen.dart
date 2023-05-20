import 'package:app/widgets/car.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/pneu_provider.dart';

class PneusScreen extends HookConsumerWidget {
  const PneusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [Car(), Tires()],
        )));
  }
}

class Tires extends HookConsumerWidget {
  const Tires({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tires = ref.watch(pneusProvider);
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
              child: TireItem(pneu: tires[0], index: 0),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TireItem(pneu: tires[1], index: 1),
            ),
          ],
        )),
        const SizedBox(height: 20),
        Expanded(
            child: Row(
          children: [
            Expanded(
              child: TireItem(pneu: tires[2], index: 2),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TireItem(pneu: tires[3], index: 3),
            ),
          ],
        )),
      ],
    );
  }
}

class TireItem extends StatelessWidget {
  const TireItem({super.key, required this.pneu, required this.index});
  final Pneu pneu;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue.shade200)),
      child: Stack(
        children: [
          Positioned(
            top: [0, 1].contains(index) ? 0 : null,
            bottom: [2, 3].contains(index) ? 0 : null,
            left: [0, 2].contains(index) ? 0 : null,
            right: [1, 3].contains(index) ? 0 : null,
            child: Column(
              crossAxisAlignment: [0, 2].contains(index)
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Text(
                  "${pneu.pressure}bar",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text('${pneu.temperature}°C'),
                //  const Expanded(child: SizedBox()),

                Text(
                  'LOW',
                  style: TextStyle(
                      color: Colors.blue.shade300, fontWeight: FontWeight.bold),
                ),
                const Text('PRESSURE')
              ],
            ),
          ),
          Positioned(
              top: [0, 1].contains(index) ? null : 0,
              bottom: [2, 3].contains(index) ? null : 0,
              left: [0, 2].contains(index) ? null : 20,
              right: [1, 3].contains(index) ? null : 20,
              child: Image.asset("assets/tire.png", height: 50))
        ],
      ),
    );
  }
}
