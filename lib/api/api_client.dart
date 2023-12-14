import 'package:http/http.dart' as http;

class ApiClient {
  final String url = 'http://10.0.0.100:3000/api/v1/users';

  Future<int> postData({required String body}) async {
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode;
  }
}
