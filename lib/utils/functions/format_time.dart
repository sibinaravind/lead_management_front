String formatDecimalMinutes(double decimalMinutes) {
  final totalSeconds = (decimalMinutes * 60).round();

  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;

  return "${hours.toString().padLeft(2, '0')}:"
      "${minutes.toString().padLeft(2, '0')}:"
      "${seconds.toString().padLeft(2, '0')}";
}
