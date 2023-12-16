import 'package:http/http.dart' as http;

class ApiClient {
  // Se for rodar o app na web, a baseUrl deve receber 'http://localhost:3000/api/v1/users'
  // Se for rodar o app em emulador android, a baseUrl deve receber 'http://valor_de_IPV4:3000/api/v1/users'
  final String baseUrl = 'http://localhost:3000/api/v1/users';

  Future<int> postData(String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode;
  }

  Future<int> login(String body) async {
    final urlToLogin = '$baseUrl/login';

    final response = await http.post(
      Uri.parse(urlToLogin),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode;
  }
}
