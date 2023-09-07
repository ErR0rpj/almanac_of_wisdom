import 'package:almanac_of_wisdom/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  //Used for main titles like app bar or main title of post
  static TextStyle titleFont({
    Color fontColor = AppColors.negativeColor,
  }) {
    return GoogleFonts.lato(
      color: fontColor,
      fontSize: 25,
    );
  }

  //Used below the titles
  static TextStyle subtitleFont({
    Color fontColor = AppColors.tertiaryColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.lato(
      color: fontColor,
      fontSize: 14,
      fontWeight: fontWeight,
    );
  }

  //Headings
  static TextStyle headingFont({
    Color fontColor = AppColors.negativeColor,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.lato(
      color: fontColor,
      fontSize: 22,
      fontWeight: fontWeight,
    );
  }
}
