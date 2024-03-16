import 'package:a_music/resource/enum.dart';
import 'package:get/get.dart';

abstract class IAuthenticate {
  Rx<UiState> get uiState;
  RxString get message;
  Future<bool> signUp({required String email, required String password});
  Future<bool> signIn({required String email, required String password});
}
