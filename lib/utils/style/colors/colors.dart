import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF222B45); // Deep Blue
  // Color(0xFF222B45); //const Color(0xFF1E293B) // Deep Blue // Color.fromARGB(255, 34, 69, 57)  green

  static const LinearGradient buttonGraidentColour = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1), // Indigo 500
      Color(0xFF8B5CF6), // Violet 500
    ],
  );
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF222B45),
      Color(0xFF3B82F6),
    ],
  );
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 247, 184, 75),
      Color(0xFFF59E0B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient backgroundGraident = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF8FAFC),
      Color(0xFFEFF6FF),
      Color(0xFFF1F5F9),
    ],
  );
  static LinearGradient blackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primaryColor,
      AppColors.primaryColor.withOpacity(0.8),
    ],
  ); // Light Blue
  static LinearGradient redGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 196, 84, 84),
      Color.fromARGB(255, 162, 13, 13),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static LinearGradient greenGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 10, 185, 129),
      Color.fromARGB(255, 0, 128, 64),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient pinkGradient = LinearGradient(
    colors: [
      Color(0xFFEC4899),
      Color(0xFFD81B60),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF1E40AF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static Color get violetPrimaryColor => Color(0xFF6366F1);

  static List<Color> roleColors = [
    Color(0xFF3B82F6),
    Color(0xFF10B981), // Light Blue
    Color(0xFF8B5CF6),
    Color(0xFFF59E0B),
    Color(0xFFEF4444), // Light Blue
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
    Color(0xFF6366F1), // Indigo 500
    Color(0xFFEC4899),
    Color(0xFF06B6D4),
  ];
  static const Color blueSecondaryColor = Color(0xFF3B82F6);
  static const Color greenSecondaryColor = Color(0xFF10B981); // Light Blue
  static const Color viloletSecondaryColor = Color(0xFF8B5CF6);
  static const Color orangeSecondaryColor = Color(0xFFF59E0B);
  static const Color redSecondaryColor = Color(0xFFEF4444); // Light Blue
  static const Color pinkSecondaryColor = Color(0xFFEC4899);
  static const Color skyBlueSecondaryColor = Color(0xFF06B6D4);

  static const Color textGrayColour = Color(0xFF94A3B8);
  static const Color textWhiteColour = Color(0xFFF1F5F9);

  static const Color iconWhiteColour = Color(0xFFE2E8F0);
  //old
  static const Color darkOrangeColour = Color(0xFFF57C00); // Amber
  static const Color whiteMainColor = Colors.white;
  static const Color offWhiteColour = Color(0xFFB0BEC5);

  // static const primaryColor = Color(0xff255175);
  // // Color(0xff255175) -> blue; Color.fromARGB(255, 117, 80, 37) --> brown; .// Color.fromARGB(255, 117, 38, 37) -> red;
  static const primaryColorBackground = Color.fromARGB(255, 226, 236, 245);
  //  Color.fromARGB(255, 226, 236, 245) ->blue ; //Color.fromARGB(255, 240, 233, 226) -> brown ;
  static const backgroundColor = Color.fromRGBO(250, 250, 250, 1);

  static const textColor = Colors.black54;
  // static const textWhiteColor = Colors.white;
  // static const whiteMainColor = Colors.white;
  static const blackMainColor = Colors.black;
  static const blackNeutralColor = Color.fromRGBO(37, 37, 37, 1);
  static const blueNeutralColor = Color(0xffEBF2FA);

  // static const darkOrangeColour = Color.fromARGB(255, 215, 140, 0);

  static const darkVioletColour = Color(0xff851B81);

  static const blueGrayColour = Color(0xffE1E8F7);

  static Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
  // static const offWhiteColour = Color(0xffEBEBEB);
}


  // static const darkGreenColour = Color(0xff229562);
  // static const liteGreenColour = Color(0xff2ABF63);
  // static const darkRedColour = Color(0xffFF0100);
  // static const darkRoseColour = Color(0xffC02A5F);
    // static const liteBlueColour = Color(0xff0FA3F1);
  // static const yellowColour = Color(0xffEAC719);
  // static const brownColour = Color(0xff501447);
  // static const darkGrayColour = Color(0xff255175);
    // static const darkBlueColour = Color(0xff001E31);
// 0XFFFFA500 - Orange
// 0XFF4CAF50 - Green
// 0XFFF44336 - Red
// 0XFF03A9F4 - Light Blue (Sky Blue)
// 0XFFFF9800 - Dark Orange
// 0XFF3F51B5 - Indigo
// 0XFF009688 - Teal
// 0XFFFFC107 - Amber
// 0XFF8BC34A - Light Green (Lime Green)
// 0XFF00BCD4 - Cyan
// 0XFFD32F2F - Dark Red
// 0XFF9C27B0 - Purple
// 0XFF607D8B - Blue Grey
// 0XFF795548 - Brown
// 0XFFBDBDBD - Grey (Light Grey)
