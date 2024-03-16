import 'dart:convert';

import 'package:a_music/controller/explore/explore_controller.dart';
import 'package:a_music/repositories/explore_songs/explore_song_repo.dart';
import 'package:a_music/resource/enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';

import 'data.dart';

void main() {
  final ExploreSongController _controller =
      ExploreSongController(exploreSongRepo: MockSongRepo());
  group('Explore Controller Test', () {
    test('Fetch Song', () async {
      expect(_controller.uiState.value == UiState.initialised, true);
      final response = await _controller.fetchAllSong();
      expect(_controller.uiState.value == UiState.data, true);
      expect(_controller.songList.songList?.isNotEmpty, true);
      expect(_controller.favouriteSong.isNotEmpty, true);
    });
  });
}

class MockSongRepo extends IExploreSongRepo {
  @override
  Future<bool> addFavourite({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> fetchFavouriteSongs() async{
    await Future.delayed(Duration(seconds: 1));
    return ["song_id_1", "song_id_2"];
  }

  @override
  Future<Response> fetchSongs() async {
    await Future.delayed(const Duration(seconds: 1));
    return Response(jsonEncode(songData), 200);
  }

  @override
  Future<bool> removeFromFav({required String id}) {
    // TODO: implement removeFromFav
    throw UnimplementedError();
  }

  @override
  Future updateFavourites() {
    // TODO: implement updateFavourites
    throw UnimplementedError();
  }

  @override
  Future upload() {
    // TODO: implement upload
    throw UnimplementedError();
  }
}
