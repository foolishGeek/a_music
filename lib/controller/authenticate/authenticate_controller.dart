import 'package:a_music/controller/authenticate/i_authenticate.dart';
import 'package:a_music/data/user/user_data.dart';
import 'package:a_music/repositories/authenticate/auth_repository.dart';
import 'package:a_music/resource/constants.dart';
import 'package:a_music/resource/enum.dart';
import 'package:a_music/resource/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AuthenticationController extends IAuthenticate {
  @override
  Rx<UiState> get uiState => _uiState;

  @override
  RxString get message => _message;

  Rx<UiState> _uiState = UiState.initialised.obs;
  RxString _message = "".obs;

  // DI
  final IUserDataStore _userDataStore;
  final IAuthRepository _authRepository;

  AuthenticationController(
      {IUserDataStore? userDataStore, IAuthRepository? authRepository})
      : this._userDataStore = userDataStore ?? UserDataStore(),
        this._authRepository = authRepository ?? AuthRepository();

  @override
  Future<bool> signIn({required String email, required String password}) async {
    _uiState.value = UiState.loading;
    bool _status = false;
    try {
      final response =
          await _authRepository.signInUser(email: email, password: password);
      if (response.user != null) {
        _message.value = StringConstants.kSignInMessage;
        _userDataStore
            .setUser(UserModel(uId: response.user?.uid ?? "", favourites: []));
        _status = true;
        await SharedPref.instance.loggedIn();
        _uiState.value = UiState.data;
      } else {
        _uiState.value = UiState.error;
      }
    } on FirebaseAuthException catch (e) {
      _uiState.value = UiState.error;
      _message.value = e.message ?? "";
    }
    return _status;
  }

  @override
  Future<bool> signUp({required String email, required String password}) async {
    _uiState.value = UiState.loading;
    bool _status = false;
    try {
      final response =
          await _authRepository.createUser(email: email, password: password);
      if (response.user != null) {
        _message.value = StringConstants.kSignInMessage;
        _userDataStore
            .setUser(UserModel(uId: response.user?.uid ?? "", favourites: []));
        await SharedPref.instance.loggedIn();
        _status = true;
        _uiState.value = UiState.data;
      } else {
        _uiState.value = UiState.error;
      }
    } on FirebaseAuthException catch (e) {
      _uiState.value = UiState.error;
      _message.value = e.message ?? "";
    }
    return _status;
  }
}
