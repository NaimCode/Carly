import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/music_provider.dart';

class MusicScreen extends HookConsumerWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final musics = ref.watch(musicProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(musicProvider.notifier).add(),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: musics.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              ref
                  .read(musicPlayerProvider.notifier)
                  .changeSong(musics[index].path);
              Get.toNamed("/music", arguments: musics[index].path);
            },
            title: Text(musics[index].path.split("/").last.split(".mp3").first),
            // subtitle:
            //     Text((musics[index].length().then((value) => value)).toString()),
            leading: const CircleAvatar(child: Icon(Icons.music_note)),
            trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios), onPressed: () {}),
          );
        },
      ),
    );
  }
}
