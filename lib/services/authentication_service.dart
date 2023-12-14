import 'dart:convert';

import 'package:login_ui/api/api_client.dart';

class AuthenticationService {
  final client = ApiClient();

  Future<String?> registerUser(String username, String password) async {
    String bodyRequest = _encodeData(username, password);

    final int responseStatus = await client.postData(body: bodyRequest);

    if (responseStatus == 201) {
      return null;
    }
    if (responseStatus == 400) {
      return 'Credencial inválida!';
    }
    if (responseStatus == 500) {
      return 'Error no servidor, tente novamente mais tarde!';
    }
  }

  // Método para logar usuário
  Future<String?> loginUser(String username, String password) async {
    String bodyRequest = _encodeData(username, password);
  }

  String _encodeData(username, password) {
    final Map<String, String> data = {
      'username': username,
      'password': password,
    };
    return jsonEncode(data);
  }
}
