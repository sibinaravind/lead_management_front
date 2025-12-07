String? formatDatetoString(dynamic dob) {
  if (dob == null) return null;
  DateTime? date;
  if (dob is DateTime) {
    date = dob;
  } else if (dob is String) {
    try {
      date = DateTime.parse(dob);
    } catch (_) {
      return dob.toString();
    }
  }
  if (date == null) return dob.toString();
  return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
}

DateTime? formatStringToDate(String dateString) {
  if (dateString.isEmpty) return null;

  try {
    final parts = dateString.split('/');
    if (parts.length != 3) return null;

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    return DateTime(year, month, day);
  } catch (e) {
    return null;
  }
}

String formatDateToYYYYMMDD(dynamic date) {
  if (date == null) return '';
  DateTime? dateTime;
  if (date is DateTime) {
    dateTime = date;
  } else if (date is String) {
    dateTime = formatStringToDate(date);
  }
  if (dateTime == null) return '';
  final year = dateTime.year.toString().padLeft(4, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
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
    return '$day/$month/$year';
  }
}

String? formatDatetoISTString(dynamic dob) {
  if (dob == null) return null;

  DateTime? date;

  if (dob is DateTime) {
    date = dob.toUtc(); // Ensure we treat it as UTC
  } else if (dob is String) {
    try {
      date = DateTime.parse(dob).toUtc(); // Parse and treat as UTC
    } catch (_) {
      return dob.toString();
    }
  }

  if (date == null) return dob.toString();

  // Convert to IST (+5:30)
  date = date.add(const Duration(hours: 5, minutes: 30));

  return "${date.day.toString().padLeft(2, '0')}/"
      "${date.month.toString().padLeft(2, '0')}/"
      "${date.year} "
      "${date.hour.toString().padLeft(2, '0')}:"
      "${date.minute.toString().padLeft(2, '0')}:"
      "${date.second.toString().padLeft(2, '0')}";
}
