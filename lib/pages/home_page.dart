import 'package:flutter/material.dart';
import 'package:login_ui/pages/login_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá, ${username.replaceFirst(username[0], username[0].toUpperCase())}',
          style: const TextStyle(fontSize: 20),
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Esta é a página home!',
              style: TextStyle(color: Colors.grey[900], fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
