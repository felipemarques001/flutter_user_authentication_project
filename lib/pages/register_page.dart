import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/components/auth_button.dart';
import 'package:login_ui/components/auth_textfield.dart';
import 'package:login_ui/components/auth_image_button_container.dart';
import 'package:login_ui/services/authentication_service.dart';
import 'package:login_ui/services/snackbar_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernamecontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _authenticationService = AuthenticationService();
  final _snackbarService = SnackbarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),

            const Icon(
              Icons.person,
              color: Colors.black,
              size: 90,
            ),

            const SizedBox(height: 10),

            // Vamos criar uma conta...
            Text(
              'Vamos criar uma conta para você!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Formulário para registrar
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthTextField(
                    hintText: 'Nome de usuário',
                    obsecureText: false,
                    controller: _usernamecontroller,
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    hintText: 'Senha',
                    obsecureText: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    hintText: 'Confirmar senha',
                    obsecureText: true,
                    controller: _password2Controller,
                    validator: passwordConfirmValidator,
                    useDefaultValidation: false,
                  ),
                  const SizedBox(height: 40),
                  AuthButton(onTap: registerUser, buttonText: 'Registrar')
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Ou continue com
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey[500]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Ou continue com',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Área para entrar com conta da Google ou Apple
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthImageButtonContainer(
                  imagePath: 'assets/images/google.png',
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                AuthImageButtonContainer(
                  imagePath: 'assets/images/apple.png',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Ir para tela de login
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
                children: [
                  const TextSpan(text: 'Já possuí uma conta?'),
                  TextSpan(
                    text: ' Entrar',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                  )
                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode ser vazio!';
    }
    if (_passwordController.text != _password2Controller.text) {
      return 'As senhas não condizem!';
    }
    return null;
  }

  void registerUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        final String username = _usernamecontroller.text;
        final String password = _passwordController.text;

        final serviceResponse =
            await _authenticationService.registerUser(username, password);

        (serviceResponse == null)
            ? showMessageUserRegistered()
            : showMessageError(serviceResponse);
      }
    } catch (e) {
      showMessageException();
    }
  }

  void showMessageUserRegistered() {
    _snackbarService.showSnackBar(
        context: context,
        message: 'Usuário cadastrado com sucesso!',
        isError: false);
  }

  void showMessageError(String message) {
    _snackbarService.showSnackBar(
      context: context,
      message: message,
      isError: true,
    );
  }

  void showMessageException() {
    _snackbarService.showSnackBar(
      context: context,
      message: 'Erro na operação, por favor tente novamente mais tarde!',
      isError: true,
    );
  }
}
