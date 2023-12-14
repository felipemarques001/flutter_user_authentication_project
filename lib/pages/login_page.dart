import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/components/auth_image_button_container.dart';
import 'package:login_ui/components/auth_button.dart';
import 'package:login_ui/components/auth_textfield.dart';
import 'package:login_ui/services/authentication_service.dart';
import 'package:login_ui/services/snackbar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernamecontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _authenticationService = AuthenticationService();
  final _snackbarService = SnackbarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Icon(
              Icons.lock,
              size: 90,
            ),

            const SizedBox(height: 30),

            // Bem vindo de volta...
            Text(
              'Bem-vindo de volta, sentimos sua falta!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Formulário para login
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextField(
                    hintText: 'Usuário',
                    obsecureText: false,
                    controller: _usernamecontroller,
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    hintText: 'Senha',
                    obsecureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 40),
                  AuthButton(onTap: loginUser, buttonText: 'Entrar'),
                ],
              ),
            ),

            // Esqueceu a senha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Ou continue com
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Ou continue com',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Área para entrar com conta da Google ou Apple
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthImageButtonContainer(
                    imagePath: 'assets/images/google.png',
                    onTap: () {},
                  ),
                  const SizedBox(width: 25),
                  AuthImageButtonContainer(
                    imagePath: 'assets/images/apple.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Ir para tela de registro
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
                children: [
                  const TextSpan(text: 'Não possui uma conta?'),
                  TextSpan(
                    text: ' Registrar',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacementNamed('/register');
                      },
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void loginUser() {
    try {
      if (_formKey.currentState!.validate()) {
        print('Form válido');
      }
    } catch (e) {
      showMessageException();
    }
  }

  void showMessageException() {
    _snackbarService.showSnackBar(
      context: context,
      message: 'Erro na operação, por favor tente novamente mais tarde!',
      isError: true,
    );
  }
}
