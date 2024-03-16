import 'package:a_music/resource/constants.dart';
import 'package:a_music/resource/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class IExploreSongRepo {
  Future<http.Response> fetchSongs();

  Future<List<String>> fetchFavouriteSongs();

  Future<List<String>> fetchFavouriteSongsLocal();

  Future<bool> addFavourite(
      {required String id, required List<String> favList});

  Future<bool> removeFromFav(
      {required String id, required List<String> favList});
}

class ExploreSongRepo extends IExploreSongRepo {
  static bool uploaded = false;

  @override
  Future<http.Response> fetchSongs() async {
    final url = Uri.parse(
        "https://musicapi.x007.workers.dev/search?q=t-series&searchEngine=wunk");
    final response = await http.get(url);
    return response;
  }

  @override
  Future<List<String>> fetchFavouriteSongs() async {
    ExploreSongRepo.uploaded = false;
    final firebaseDb = FirebaseFirestore.instance.collection('favourite');
    final uId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final value = await firebaseDb.doc(uId).get();
    final json = value.data();
    if (json?[StringConstants.kFavKey] == null) {
      return <String>[];
    }
    final lists = List<String>.from(json?[StringConstants.kFavKey] as List);
    final localList = await fetchFavouriteSongsLocal();

    lists.addAll(localList);
    return lists;
  }

  Future<bool> _hasInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }

  @override
  Future<bool> removeFromFav(
      {required String id, required List<String> favList}) async {
    bool res = true;
    final _set = {...favList};
    _set.remove(id);
    if (await _hasInternet()) {
      await _uploadToFirebase(_set.toList());
    } else {
      await SharedPref.instance.setStringList(
          key: StringConstants.kFavLocalDbKey, values: _set.toList());
    }
    return res;
  }

  Future _uploadToFirebase(List<String> fav) async {
    final firebaseDb = FirebaseFirestore.instance.collection('favourite');
    final uId = FirebaseAuth.instance.currentUser?.uid ?? "";
    await firebaseDb.doc(uId).set({StringConstants.kFavKey: fav});
  }

  @override
  Future<bool> addFavourite(
      {required String id, required List<String> favList}) async {
    bool res = true;
    final _set = {...favList};
    _set.add(id);
    if (await _hasInternet()) {
      await _uploadToFirebase(_set.toList());
    } else {
      await SharedPref.instance.setStringList(
          key: StringConstants.kFavLocalDbKey, values: _set.toList());
    }
    return res;
  }

  @override
  Future<List<String>> fetchFavouriteSongsLocal() async {
    final list =
        await SharedPref.instance.getList(key: StringConstants.kFavLocalDbKey);
    return list;
  }
}
