import 'package:login_ui/value_objects/value_object.dart';

class Username implements ValueObject {
  final String _value;

  Username(this._value);

  @override
  String? validator(String? valueToCompare) {
    if (_value.isEmpty) {
      return 'O nome de usuário não pode ser vazio';
    }
    return null;
  }

  String get getValue => _value;
}
