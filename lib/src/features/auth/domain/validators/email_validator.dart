
class EmailValidator {
  static const String _emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(_emailRegex).hasMatch(value)) {
      return 'Email must be a valid email address';
    }
    return null;
  }
}