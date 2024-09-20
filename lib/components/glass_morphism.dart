import "dart:ui";
import "package:flutter/material.dart";
// import "package:txn_layout_builder/constants/hex_codes.dart";
// import "package:txn_layout_builder/constants/padding_sizes.dart";

class GlassmorphicContainer extends StatelessWidget {
  final double width;
  final double? height;
  final double borderRadius;
  final double blur;
  final double border;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;
  final Widget child;
  const GlassmorphicContainer({
    required this.width,
    this.height,
    required this.borderRadius,
    required this.blur,
    required this.border,
    required this.linearGradient,
    required this.borderGradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: linearGradient,
            border: Border.all(
              color: Colors.white.withOpacity(1),
              width: border,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(border),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: borderGradient,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
