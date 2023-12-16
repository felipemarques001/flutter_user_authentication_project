import 'package:login_ui/value_objects/value_object.dart';

class Password implements ValueObject {
  final String _value;

  Password(this._value);

  @override
  String? validator(String? valueToCompare) {
    if (_value.isEmpty) {
      return 'A senha não pode ser vazia';
    }
    return null;
  }

  String get getValue => _value;
}
