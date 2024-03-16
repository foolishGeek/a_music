import 'dart:convert';

import 'package:a_music/data/explore/songs.dart';
import 'package:a_music/repositories/explore_songs/explore_song_repo.dart';
import 'package:a_music/resource/enum.dart';
import 'package:get/get.dart';

abstract class IExploreSong {
  Rx<UiState> get uiState;

  SongList get songList;

  Future<void> fetchAllSong();

  Future fetchFavouriteSongs();

  Future<bool> addFav(
    int id,
  );

  bool isFav(int idx);
}

class ExploreSongController extends IExploreSong {
  final IExploreSongRepo _exploreSongRepo;

  ExploreSongController({IExploreSongRepo? exploreSongRepo})
      : this._exploreSongRepo = exploreSongRepo ?? ExploreSongRepo();

  @override
  SongList get songList => _songList;

  @override
  Rx<UiState> get uiState => _uiState;

  SongList _songList = SongList(status: 0, message: "");
  Rx<UiState> _uiState = UiState.initialised.obs;

  List<String> favouriteSong = <String>[];

  @override
  Future<void> fetchAllSong() async {
    _uiState.value = UiState.loading;
    final response = await _exploreSongRepo.fetchSongs();
    if (response.statusCode == 200) {
      _songList = SongList.fromJson(jsonDecode(response.body));
      await fetchFavouriteSongs();
      _uiState.value = UiState.data;
    } else {
      _uiState.value = UiState.error;
    }
  }

  @override
  Future fetchFavouriteSongs() async {
    final list = await _exploreSongRepo.fetchFavouriteSongs();
    favouriteSong = list.toSet().toList();
  }

  @override
  bool isFav(int idx) {
    bool isFav = false;
    for (var item in favouriteSong) {
      if (item == (songList.songList?[idx].id ?? "")) {
        isFav = true;
        break;
      }
    }
    return isFav;
  }

  @override
  Future<bool> addFav(
    int id,
  ) async {
    bool res = false;
    if (favouriteSong.isNotEmpty && isFav(id)) {
      res = await _exploreSongRepo.removeFromFav(
          id: (songList.songList?[id].id ?? ""),
          favList: favouriteSong.toList());
      if (res) {
        favouriteSong
            .removeWhere((val) => val == (songList.songList?[id].id ?? ""));
      }
    } else {
      res = await _exploreSongRepo.addFavourite(
          id: (songList.songList?[id].id ?? ""),
          favList: favouriteSong.toList());
      if (res) {
        favouriteSong.add((songList.songList?[id].id ?? ""));
      }
    }
    return res;
  }
}
