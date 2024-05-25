import 'package:flutter/material.dart';

EdgeInsets getResponsivePadding(BuildContext context) {
  return EdgeInsets.symmetric(
    vertical: 10,
    horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? 20 : 100,
  );
}

BoxDecoration getGradientDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 232, 232, 232),
        Color.fromARGB(255, 0, 183, 255),
        Color.fromARGB(255, 0, 183, 255),
        Color.fromARGB(255, 255, 0, 115),
        Color.fromARGB(255, 255, 0, 115),
        Colors.yellow
      ],
      stops: [0.79, 0.79, 0.865, 0.865, 0.94, 0.94],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    )
  );
}