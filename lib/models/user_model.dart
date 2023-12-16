import 'package:login_ui/value_objects/confirm_password.dart';
import 'package:login_ui/value_objects/password.dart';
import 'package:login_ui/value_objects/username.dart';

class UserModel {
  Username username;
  Password password;
  ConfirmPassword confirmPassword;

  UserModel({
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  factory UserModel.empty() {
    return UserModel(
      username: Username(''),
      password: Password(''),
      confirmPassword: ConfirmPassword(''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username.getValue.toString(),
      'password': password.getValue.toString(),
    };
  }

  void setUsername(String? value) => username = Username(value ?? '');
  void setPassword(String? value) => password = Password(value ?? '');
  void setConfirmPassword(String? value) =>
      confirmPassword = ConfirmPassword(value ?? '');
}
