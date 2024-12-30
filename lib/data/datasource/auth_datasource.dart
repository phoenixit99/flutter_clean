import '../model/user_model.dart';

class AuthDatasource {
  Future<UserModel> login(String email, String password) async {
    // Simulate an API call
    await Future.delayed(const Duration(seconds: 2));
    if (email == "test@example.com" && password == "password") {
      return UserModel(id: "1", name: "Test User", email: email);
    } else {
      throw Exception("Invalid credentials");
    }
  }
}