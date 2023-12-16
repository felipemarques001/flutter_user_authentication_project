import 'package:flutter/material.dart';

class SnackbarService {
  void showSnackBar({
    required BuildContext context,
    required String message,
    required bool isError,
  }) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      backgroundColor: (isError) ? Colors.red[500] : Colors.green[500],
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showUserRegisteredMessage(BuildContext context) {
    showSnackBar(
        context: context,
        message: 'Usuário cadastrado com sucesso!',
        isError: false);
  }

  void showUserLogedMessage(BuildContext context) {
    showSnackBar(
        context: context,
        message: 'Usuário logado com sucesso!',
        isError: false);
  }

  void showErrorMessage(BuildContext context, String message) {
    showSnackBar(
      context: context,
      message: message,
      isError: true,
    );
  }

  void showExceptionMessage(BuildContext context) {
    showSnackBar(
      context: context,
      message: 'Erro na operação, por favor tente novamente mais tarde!',
      isError: true,
    );
  }
}
