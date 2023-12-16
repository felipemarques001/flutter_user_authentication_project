import 'dart:convert';

import 'package:login_ui/api/api_client.dart';
import 'package:login_ui/models/user_model.dart';

class AuthenticationService {
  final client = ApiClient();

  Future<String?> registerUser(UserModel user) async {
    final int responseStatus = await client.postData(jsonEncode(user.toJson()));

    if (responseStatus == 201) {
      return null;
    }
    if (responseStatus == 400) {
      return 'Nome de usuário já em uso!';
    }
    if (responseStatus == 500) {
      return 'Error no servidor, tente novamente mais tarde!';
    }
  }

  Future<String?> loginUser(UserModel user) async {
    final int responseStatus = await client.login(jsonEncode(user.toJson()));

    if (responseStatus == 200) {
      return null;
    }
    if (responseStatus == 400) {
      return 'Credenciais inválidas!';
    }
    if (responseStatus == 404) {
      return 'Usuário não encontrado!';
    }
    if (responseStatus == 500) {
      return 'Error no servidor, tente novamente mais tarde!';
    }
  }
}
