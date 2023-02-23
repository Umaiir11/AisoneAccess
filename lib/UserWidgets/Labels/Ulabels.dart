import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ULabels extends StatelessWidget {
  late final String text;
  late final double fontSize;
  late final Color color;

  String get TxtText {
    return text;
  }

  void set TxtText(String l_text) {
    text = l_text;
  }

  double get TxtFontSize {
    return fontSize;
  }

  void set TxtFontSize(double l_FontSize) {
    fontSize = l_FontSize;
  }

  Color get TxtColor {
    return color;
  }

  void set TxtColor(Color l_color) {
    color = l_color;
  }

  @override
  Widget build(BuildContext context) {
      TextStyle l_TestStyle = TextStyle(
          fontSize: TxtFontSize,
          color: TxtColor,
          fontWeight: FontWeight.w600,
          letterSpacing: .5);

    return Text(TxtText,
        style: GoogleFonts.ubuntu(
          textStyle: l_TestStyle,
        ));
  }
}
