import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MusicNotifier extends StateNotifier<List<File>> {
  MusicNotifier() : super([]) {
    init();
  }
  void init() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      state = [
        ...state,
        ...result.paths
            .where((element) => element != null)
            .map((path) => File(path!))
            .toList()
      ];
    } else {
      // User canceled the picker
    }
  }

  void pick() {
    init();
  }

  void add() {
    init();
  }
}

final musicProvider =
    StateNotifierProvider<MusicNotifier, List<File>>((ref) => MusicNotifier());

class MusicPlayerNotifier extends StateNotifier<AssetsAudioPlayer> {
  MusicPlayerNotifier(super._state);

  void play() {
    state.play();
  }

  void pause() {
    state.pause();
  }

  void stop() {
    state.stop();
  }

  void playPause() {
    state.playOrPause();
  }

  void volume(double volume) {
    state.setVolume(volume);
  }

  void changeSong(String url) {
    state.open(Audio.file(url), autoStart: true);
  }

  void seek(Duration duration) {
    state.seek(duration);
  }
}

final musicPlayerProvider =
    StateNotifierProvider<MusicPlayerNotifier, AssetsAudioPlayer>((ref) {
  return MusicPlayerNotifier(AssetsAudioPlayer());
});
