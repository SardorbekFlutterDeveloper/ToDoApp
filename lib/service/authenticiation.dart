import 'package:hive/hive.dart';
import 'package:todoapp/model/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());

    _users = await Hive.openBox("userBox");
  }

  Future<String?> authenticeUser(
      final String username, final String password) async {
    final success = await _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null; 
    }
  }
}
