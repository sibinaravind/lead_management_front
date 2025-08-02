String formatDatetoString(DateTime? selectedDate) {
  if (selectedDate == null) return '';
  final year = selectedDate.year.toString().padLeft(4, '0');
  final month = selectedDate.month.toString().padLeft(2, '0');
  final day = selectedDate.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

String getRelativeDayString(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final inputDate = DateTime(date.year, date.month, date.day);

  if (inputDate == today) {
    return 'Today';
  } else if (inputDate == today.subtract(const Duration(days: 1))) {
    return 'Yesterday';
  } else if (inputDate == today.add(const Duration(days: 1))) {
    return 'Tomorrow';
  } else {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
