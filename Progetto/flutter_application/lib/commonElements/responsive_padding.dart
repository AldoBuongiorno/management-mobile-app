import 'package:flutter/material.dart';

EdgeInsets getResponsivePadding(BuildContext context) {
  return EdgeInsets.symmetric(
    vertical: 10,
    horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? 20 : 100,
  );
}

