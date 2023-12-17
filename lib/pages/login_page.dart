import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/components/auth_image_button_container.dart';
import 'package:login_ui/components/auth_button.dart';
import 'package:login_ui/components/auth_textfield.dart';
import 'package:login_ui/models/user_model.dart';
import 'package:login_ui/pages/home_page.dart';
import 'package:login_ui/pages/register_page.dart';
import 'package:login_ui/services/authentication_service.dart';
import 'package:login_ui/services/snackbar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _snackbarService = SnackbarService();
  final _authenticationService = AuthenticationService();
  final _user = UserModel.empty();

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
            const SizedBox(height: 60),
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
                    label: 'Nome de usuário',
                    validator: (value) => _user.username.validator(''),
                    onChanged: (value) => _user.setUsername(value),
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    label: 'Senha',
                    obsecureText: true,
                    validator: (value) => _user.password.validator(''),
                    onChanged: (value) => _user.setPassword(value),
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
                      ..onTap = () => openNewPage(const RegisterPage()),
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

  // Faz uma nova página ser aberta, estava chamando o Navigator
  // mais de uma vez, então criei esta função para não repetir o código
  void openNewPage(dynamic page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Método responsável por validar os formulários e fazer a requisição de login
  void loginUser() async {
    try {
      // Só entra no if se todos os formulário estiverem validados
      if (_formKey.currentState!.validate()) {
        final serviceResponse = await _authenticationService.loginUser(_user);

        (serviceResponse == null)
            ? actionsToUserLogged()
            : actionsToErrorInLoginUser(serviceResponse);
      }
    } catch (e) {
      print(e);
      actionToException();
    }
  }

  // Ações que devem ser feitas quando o usuário logar com sucesso!
  void actionsToUserLogged() {
    FocusScope.of(context).unfocus();
    openNewPage(HomePage(username: _user.username.getValue));
  }

  // Ações que devem ser feitas quando houver erro para logar o usuário!
  void actionsToErrorInLoginUser(String message) {
    _snackbarService.showErrorMessage(context, message);
    FocusScope.of(context).unfocus();
  }

  // Ação que deve ser feita se caso houver uma exceção durante o processo
  void actionToException() {
    _snackbarService.showExceptionMessage(context);
  }
}
