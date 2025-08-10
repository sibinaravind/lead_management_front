MapEntry<String, String>? splitPhoneNumber(
  String? phone, {
  String defaultCode = '+91',
  List<String> separators = const [' ', '-'],
}) {
  // Return null for empty input
  if (phone == null || phone.isEmpty) return null;

  // Try each possible separator
  for (final separator in separators) {
    if (phone.contains(separator)) {
      final parts = phone.split(separator);
      return MapEntry(
        parts.first.isNotEmpty ? parts.first : defaultCode,
        parts.sublist(1).join(),
      );
    }
  }

  // No separator found - return default code with entire string as number
  return MapEntry(defaultCode, phone);
}
