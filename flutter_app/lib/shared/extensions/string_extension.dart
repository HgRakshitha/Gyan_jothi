extension StringExtension on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String truncate(int maxLength) =>
      length > maxLength ? '${substring(0, maxLength)}…' : this;

  bool get isValidEmail {
    final regex = RegExp(r'^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(this);
  }
}
