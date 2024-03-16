import 'package:a_music/data/explore/songs.dart';
import 'package:a_music/resource/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pausable_timer/pausable_timer.dart';

abstract class ISongDetailController {
  RxDouble get currentProgress;

  RxBool get isPlaying;

  SongDetail get songDetails;

  String get tag;

  String getSongUrl();

  void dispose();

  Future play();

  Future pause();

  Future setup();

  Future stop();

}

class SongDetailsController extends ISongDetailController {
  final SongDetail _songDetails;
  final String _tag;
  RxDouble _currentProgress = 0.0.obs;
  double _currentTime = 0.0;
  int songDuration = 0;
  final _audioPlayer = AudioPlayer();
  PausableTimer? _timer;
  RxBool _isPlaying = false.obs;

  SongDetailsController({required SongDetail songDetails, required String tag})
      : this._tag = tag,
        this._songDetails = songDetails;

  @override
  String getSongUrl() {
    return StringConstants.kSongUrl + songDetails.id;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
  }

  @override
  Future play() async {
    _isPlaying.value = true;
    _timer?.start();
    _audioPlayer.play();
  }

  @override
  Future pause() async {
    _isPlaying.value = false;
    _timer?.pause();
    _audioPlayer.pause();
  }

  @override
  Future setup() async {
    final song = await _audioPlayer.setUrl(getSongUrl());
    songDuration = song?.inSeconds ?? 0;
    _timer = PausableTimer.periodic(Duration(seconds: 1), () {
      if (_currentTime > songDuration) {
        _timer?.cancel();
        stop();
      } else {
        _currentTime += 1;
        _currentProgress.value = (_currentTime / songDuration);
      }
    });
  }

  @override
  Future stop() async {
    _audioPlayer.stop();
    _timer?.reset();
  }

  @override
  SongDetail get songDetails => _songDetails;

  @override
  String get tag => _tag;

  @override
  RxDouble get currentProgress => _currentProgress;

  @override
  RxBool get isPlaying => _isPlaying;
}
