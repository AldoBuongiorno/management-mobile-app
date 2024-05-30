import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBox extends StatelessWidget {
  BlurredBox({required this.child, required this.borderRadius, required this.sigma});
  late final BorderRadius borderRadius;
  late final Widget child;
  late final double sigma;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma), child: child),
        );
  }
}
