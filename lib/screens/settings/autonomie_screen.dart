import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../widgets/car.dart';

class AutonomieScreen extends HookConsumerWidget {
  const AutonomieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Lottie.asset("assets/autonomie.json",
                        animate: false, frameRate: FrameRate(120)),
                  ),
                  const SizedBox(height: 4),
                  Text("3L/100km",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const Expanded(child: Car())
          ],
        )));
  }
}
