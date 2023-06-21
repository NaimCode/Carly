import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/fenetre_provider.dart';

class FenetreScreen extends HookConsumerWidget {
  const FenetreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final siege = ref.watch(fenetreProvider);
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
            child: Transform.translate(
          offset: Offset(0, 300 - siege["vertical"]!.toDouble()),
          child: Image.asset(
            "assets/window.png",
            fit: BoxFit.contain,
            //height: 400,
            width: 300,
          ),
        )),
        Positioned(
            right: 4,
            child: RotatedBox(
              quarterTurns: 3,
              child: Center(
                child: SizedBox(
                  width: 220,
                  child: Slider(
                    value: siege["vertical"]!.toDouble(),
                    min: 0,
                    max: 300,
                    onChanged: (value) {
                      ref.read(fenetreProvider.notifier).changeVertical(value);
                    },
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
