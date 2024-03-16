abstract class IUserDataStore {
  UserModel? get user;

  void setUser(UserModel user);

  List<String?> getFavourites();
}

class UserDataStore extends IUserDataStore {
  UserModel? _user;

  static final _instance = UserDataStore._internal();

  UserDataStore._internal({UserModel? setUser}) : _user = setUser;

  factory UserDataStore() {
    return _instance;
  }

  @override
  void setUser(UserModel user) {
    _user = user;
  }

  @override
  UserModel? get user => _user;

  @override
  List<String?> getFavourites() {
    return [];
  }
}

/*User data model*/
class UserModel {
  String uId;
  List<String> favourites;

  UserModel({required this.uId, required this.favourites});
}
