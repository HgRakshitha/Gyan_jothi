import 'package:intl/intl.dart';

class Helpers {
  Helpers._();

  /// Format a coin count with commas e.g. 3200 → "3,200"
  static String formatCoins(int coins) =>
      NumberFormat('#,##0').format(coins);

  /// Relative time string e.g. "30 mins ago"
  static String timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return '${diff.inDays} days ago';
  }

  /// Capitalise first letter of a string
  static String capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}
