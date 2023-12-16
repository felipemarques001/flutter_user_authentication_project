import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/components/auth_button.dart';
import 'package:login_ui/components/auth_textfield.dart';
import 'package:login_ui/components/auth_image_button_container.dart';
import 'package:login_ui/models/user_model.dart';
import 'package:login_ui/pages/login_page.dart';
import 'package:login_ui/services/authentication_service.dart';
import 'package:login_ui/services/snackbar_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authenticationService = AuthenticationService();
  final _snackbarService = SnackbarService();
  final _user = UserModel.empty();

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
                    label: 'Nome de usuário',
                    validator: (value) => _user.username.validator(null),
                    onChanged: (value) => _user.setUsername(value),
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    label: 'Senha',
                    validator: (value) => _user.password.validator(null),
                    obsecureText: true,
                    onChanged: (value) => _user.setPassword(value),
                  ),
                  const SizedBox(height: 10),
                  AuthTextField(
                    label: 'Confirmar senha',
                    obsecureText: true,
                    validator: (value) => _user.confirmPassword
                        .validator(_user.password.getValue),
                    onChanged: (value) => _user.setConfirmPassword(value),
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
                      recognizer: TapGestureRecognizer()..onTap = openLoginPage)
                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  // Método responsável por validar os formulários e fazer a requisição de registro
  void registerUser() async {
    try {
      // Só entra no if se todos os formulário estiverem validados
      if (_formKey.currentState!.validate()) {
        final serviceResponse =
            await _authenticationService.registerUser(_user);

        (serviceResponse == null)
            ? actionsToUserRegistered()
            : actionsToErrorInRegisterUser(serviceResponse);
      }
    } catch (e) {
      actionToException();
    }
  }

  void openLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // Ações que devem ser feitas quando o usuário ser registrado com sucesso!
  void actionsToUserRegistered() {
    _snackbarService.showUserRegisteredMessage(context);
    FocusScope.of(context).unfocus();
    // Faz a página de login ser aberta
    openLoginPage();
  }

  // Ações que devem ser feitas quando houver erro para registrar o usuário!
  void actionsToErrorInRegisterUser(String message) {
    _snackbarService.showErrorMessage(context, message);
    FocusScope.of(context).unfocus();
  }

  // Ação que deve ser feita se caso houver uma exceção durante o processo
  void actionToException() {
    _snackbarService.showExceptionMessage(context);
  }
}
