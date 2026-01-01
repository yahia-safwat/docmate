import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // For now, we use a mock implementation.
  // In a real app, this would use a Client (Dio or Http) to call an API.

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test@example.com' && password == '000000') {
      return const UserModel(
        id: '1',
        email: 'test@example.com',
        name: 'Ahmed Yahia',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
    );
  }
}
