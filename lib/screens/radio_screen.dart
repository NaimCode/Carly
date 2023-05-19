import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../providers/radio_provider.dart';

String _radioUrl = "http://stream.live.vc.bbcmedia.co.uk/bbc_radio_one";

class RadioScreen extends HookConsumerWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioPlayerProvider);
    final isPlaying = useStream(radio.isPlaying);
    final isBuffering = useStream(radio.isBuffering);
    final volume = useStream(radio.volume);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "BBC Radio",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                      child: Lottie.asset('assets/stereo.json',
                          animate: isPlaying.data)),
                  Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: isBuffering.data == true
                          ? const CircularProgressIndicator()
                          : IconButton.filledTonal(
                              iconSize: 45,
                              onPressed: () {
                                // radio.isPlaying.data
                                isPlaying.data == true
                                    ? ref
                                        .read(radioPlayerProvider.notifier)
                                        .pause()
                                    : ref
                                        .read(radioPlayerProvider.notifier)
                                        .play();
                              },
                              icon: AnimatedIcon(
                                  icon: AnimatedIcons.pause_play,
                                  progress:

                                      // radio.isPlaying.data
                                      isPlaying.data == true
                                          ? const AlwaysStoppedAnimation(0)
                                          : const AlwaysStoppedAnimation(1))),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: volume.data == null
                        ? null
                        : () {
                            ref
                                .read(radioPlayerProvider.notifier)
                                .volume(volume.data! - 0.2);
                          },
                    icon: const Icon(Icons.volume_down)),
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LinearProgressIndicator(
                        value: volume.data,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            AlwaysStoppedAnimation(Colors.blue.shade300)),
                  ),
                ),
                IconButton(
                    onPressed: volume.data == null
                        ? null
                        : () {
                            ref
                                .read(radioPlayerProvider.notifier)
                                .volume(volume.data! + 0.2);
                          },
                    icon: const Icon(Icons.volume_up)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
