import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/siege_provider.dart';

class SiegeScreen extends HookConsumerWidget {
  const SiegeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siege = ref.watch(siegeProvider);
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
            child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Transform.translate(
            offset: Offset((-1 * siege["horizontal"]!.toDouble()), 0),
            child: Transform.rotate(
              angle: siege["vertical"]!.toDouble(),
              child: Image.asset(
                "assets/seat.png",
                fit: BoxFit.cover,
                //height: 400,
                width: 100,
              ),
            ),
          ),
        )),
        Positioned(
            bottom: 0,
            child: Center(
              child: SizedBox(
                width: 300,
                child: Slider(
                  min: -50,
                  max: 50,
                  value: siege["horizontal"]!.toDouble(),
                  onChanged: (value) {
                    ref
                        .read(siegeProvider.notifier)
                        .change("horizontal", value);
                  },
                ),
              ),
            )),
        Positioned(
            right: 20,
            child: RotatedBox(
              quarterTurns: 3,
              child: Center(
                child: SizedBox(
                  width: 220,
                  child: Slider(
                    value: siege["vertical"]!.toDouble(),
                    min: -0.5,
                    max: 0.5,
                    onChanged: (value) {
                      ref
                          .read(siegeProvider.notifier)
                          .change("vertical", value);
                    },
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
