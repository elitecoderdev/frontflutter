// lib/src/utils/validators.dart

class Validators {
  /// Returns an error string if [value] is not a valid email.
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(value) ? null : 'Enter a valid email';
  }

  /// Returns an error string if [value] does not meet password rules.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Minimum 6 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Must include an uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Must include a lowercase letter';
    }
    if (!RegExp(r'[\W_]').hasMatch(value)) {
      return 'Must include a special character';
    }
    return null;
  }
}
