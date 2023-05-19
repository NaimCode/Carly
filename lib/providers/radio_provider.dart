import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RadioPlayerNotifier extends StateNotifier<AssetsAudioPlayer> {
  RadioPlayerNotifier(super.state, {required this.url}) {
    state.open(Audio.network(url), autoStart: false);
  }
  final String url;

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
}

final radioPlayerProvider =
    StateNotifierProvider<RadioPlayerNotifier, AssetsAudioPlayer>((ref) {
  return RadioPlayerNotifier(AssetsAudioPlayer(),
      url: "http://stream.live.vc.bbcmedia.co.uk/bbc_radio_one");
});
