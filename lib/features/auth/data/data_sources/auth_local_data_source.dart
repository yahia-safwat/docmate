import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> clearCache();
  Future<UserModel?> getCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // This will eventually use shared_preferences or a secure storage.
  UserModel? _cachedUser;

  @override
  Future<void> cacheUser(UserModel user) async {
    _cachedUser = user;
  }

  @override
  Future<void> clearCache() async {
    _cachedUser = null;
  }

  @override
  Future<UserModel?> getCachedUser() async {
    return _cachedUser;
  }
}
