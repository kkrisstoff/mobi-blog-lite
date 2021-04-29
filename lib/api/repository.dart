import 'HTTP_client.dart';
import '../screens/UsersScreen/users_screen.dart';
import '../screens/AuthScreen/auth.dart';

abstract class UserRepository {
  Future<LoggedUser> login(String username, String password);

  Future<User> getUser();

  Future<List<User>> getAllUsers();
}

class _Urls {
  // static const baseUrl = "https://py-blog-lite.herokuapp.com/api/v0/";
  static const baseUrl = "http://localhost:5000/api/v0/";
  static const login = "${baseUrl}login";
  static const user = "${baseUrl}user";
  static const allUsers = "${baseUrl}users";
}

class RestRepository extends UserRepository {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<LoggedUser> login(username, password) async {
    final Map<String, dynamic> loggedInUser = await _httpClient
        .postRequest(_Urls.login, {'username': username, 'password': password});

    if (loggedInUser.isEmpty) {
      // throw EmptyResultException();
    }

    return LoggedUser.fromJson(loggedInUser);
  }

  @override
  Future<User> getUser() async {
    final Map<String, dynamic> userJson =
        await _httpClient.getRequest(_Urls.user);

    return User.fromJson(userJson);
  }

  @override
  Future<List<User>> getAllUsers() async {
    print(_Urls.allUsers);
    final List<dynamic> userListJson =
        await _httpClient.getRequest(_Urls.allUsers);

    return userListJson.map((userJson) => User.fromJson(userJson)).toList();
  }
}
