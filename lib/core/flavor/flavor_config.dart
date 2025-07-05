import 'package:flutter/material.dart';

import '../../config/flavour_config.dart';

class FlavorConfigration {
  final Partner? name;
  final Color color;
  FlavorConfigration._internal(this.name, this.color);
  static FlavorConfigration? _instance;
  static FlavorConfigration get instance {
    _instance ??= FlavorConfigration();

    return _instance!;
  }

  factory FlavorConfigration({
    Partner? name,
    Color color = Colors.red,
  }) {
    _instance = FlavorConfigration._internal(
      name,
      color,
    );

    return _instance!;
  }
}
