// import 'package:dynamic_widget/dynamic_widget/constants/dynamic_hex_codes..dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FontManager {
  TextStyle getTextStyle(BuildContext context,
      {Color color = Colors.black,
      FontWeight lWeight = FontWeight.w400,
      lineHeight = 1.0,
      maxLines = 2,
      textDirection = TextDirection.ltr,
      textAlign = TextAlign.start,
      String fontName = "Inter",
      FontStyle lFontStyle = FontStyle.normal,
      softWrap = false,
      decorationColor = Colors.black,
      double fontSize = 12.0,
      decoration = TextDecoration.none,
      letterSpacing = 0.0,
      TextOverflow overflow = TextOverflow.visible,
      
      decorationThickness = 0.0,
      
      decorationStyle = TextDecorationStyle.solid}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: lWeight,
      height: lineHeight,
      fontStyle: lFontStyle,
      fontFamily: fontName,
      color: color,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      decorationStyle: decorationStyle,
      
    );
  }
}
