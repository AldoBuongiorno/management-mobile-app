import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBox extends StatelessWidget {
  const BlurredBox({super.key, required this.child, required this.borderRadius, required this.sigma});
  final BorderRadius borderRadius;
  final Widget child;
  final double sigma;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma), child: child),
    );
  }
}
