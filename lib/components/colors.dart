import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColor = Color(0xFFFAFAFA);
  static const textColor = Color(0xFF000000);
  static const iconColor = Color(0xFF838383);

  static final greyGradient = LinearGradient(colors: [const Color(0xFFE4E4E7).withOpacity(0.4), const Color(0xFFE4E4E7).withOpacity(0.4)]);
  static const gradientColor = LinearGradient(
    colors: [Color(0xFFA0DAFB), Color(0xFF0A8ED9)],
    begin: FractionalOffset.topCenter,
    end: FractionalOffset.bottomCenter,
  );
}
