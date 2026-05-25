/// Case-insensitive substring match on any of [fields]. Empty or whitespace [query] matches all.
bool matchesSearchQuery(String query, Iterable<String> fields) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return true;
  for (final raw in fields) {
    final f = raw
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();
    if (f.contains(q)) return true;
  }
  return false;
}
