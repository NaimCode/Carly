import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../providers/music_provider.dart';
import '../providers/radio_provider.dart';

class MusicItemScreen extends HookConsumerWidget {
  const MusicItemScreen({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(musicPlayerProvider);
    final isPlaying = useStream(radio.isPlaying);
    final isBuffering = useStream(radio.isBuffering);
    final volume = useStream(radio.volume);

    //after widget built
    // ref.read(musicPlayerProvider.notifier).changeSong(path);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Music"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 500,
                child: Text(
                  path.split("/").last.split(".mp3").first,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
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
                                        .read(musicPlayerProvider.notifier)
                                        .pause()
                                    : ref
                                        .read(musicPlayerProvider.notifier)
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
