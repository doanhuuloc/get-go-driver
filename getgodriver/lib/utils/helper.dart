import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Helper {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static void playRingSound(String url, double volumn) {
    try {
      if (_audioPlayer.playing) {
        _audioPlayer.stop();
      }
      print("cout << play ring sound");
      print("cout << $url , ");
      _audioPlayer.setVolume(volumn);
      _audioPlayer.setUrl(url);
      _audioPlayer.play();
    } catch (err) {
      throw (err);
    }
  }

  static void stopRingSound() async {
    try {
      if (_audioPlayer.playing) {
        print("cout << stop ring sound");
        await _audioPlayer.stop();
      }
    } catch (err) {
      throw (err);
    }
  }
}
