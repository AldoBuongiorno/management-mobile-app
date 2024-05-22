import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBox extends StatelessWidget {
  BlurredBox({required this.child, required this.borderRadius, required this.sigma});
  late final double borderRadius;
  late final Widget child;
  late final double sigma;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma), child: child),
        );
  }
}
