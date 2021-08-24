import 'package:loginsql/models/user.dart';
import 'package:loginsql/utils/network_util.dart';

class RestData {
  NetworkUtil _netutil = NetworkUtil();

  static final BASE_URl = "";
  static final LOGIN_URL = BASE_URl + "/";

  Future<User>? login(String username, String password) {
    return new Future.value(new User(username, password));
  }
}
