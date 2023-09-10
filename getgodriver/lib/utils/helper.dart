import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Helper {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playRingSound(String url, double volumn) async {
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
      print("lỗi âm thanh: $err");
      return;
    }
  }

  static void stopRingSound() async {
    try {
      if (_audioPlayer.playing) {
        print("cout << stop ring sound");
        await _audioPlayer.stop();
      }
    } catch (err) {
      print("lỗi âm thanh stop: $err");
      return;
    }
  }
}
