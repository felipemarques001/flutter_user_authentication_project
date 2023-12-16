import 'package:login_ui/value_objects/value_object.dart';

class ConfirmPassword implements ValueObject {
  final String _value;

  ConfirmPassword(this._value);

  @override
  String? validator(String? valueToCompare) {
    if (_value.isEmpty) {
      return 'Por favor, confirme a senha';
    }
    if (_value != valueToCompare) {
      return 'As senhas não condizem';
    }
    return null;
  }
}
