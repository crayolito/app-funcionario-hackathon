import 'package:app_sw1final/config/constant/colors.const.dart';
import 'package:app_sw1final/config/constant/shadow.const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterStyle {
  BuildContext context;

  LetterStyle(this.context);

  Size get size => MediaQuery.of(context).size;

  // READ : HOME SCREEN
  TextStyle get titulo => GoogleFonts.sourceCodePro(
      color: Colors.white,
      fontSize: size.width * 0.09,
      fontWeight: FontWeight.bold,
      shadows: shadowKPN2);

  TextStyle get titulo2 => GoogleFonts.kaushanScript(
      color: Colors.white, fontSize: size.width * 0.07, shadows: shadowKPN1);

  TextStyle get tituloAuthInit => GoogleFonts.aBeeZee(
        color: kPrimaryColor,
        fontSize: size.width * 0.07,
        fontWeight: FontWeight.bold,
      );

  TextStyle get placeholderInputAuth => GoogleFonts.aBeeZee(
        fontSize: size.width * 0.055,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get letraInputAuth => GoogleFonts.aBeeZee(
        fontSize: size.width * 0.055,
        color: kTerciaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get letraButtonForm => GoogleFonts.aBeeZee(
        fontSize: size.width * 0.055,
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get letraMessageForm => GoogleFonts.aBeeZee(
        fontSize: size.width * 0.04,
        color: kTerciaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get letraMessageForm2 => GoogleFonts.aBeeZee(
        fontSize: size.width * 0.04,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );

  // READ : GENERAR DENUNCIA SCREEN

  TextStyle get letra1GD => GoogleFonts.aBeeZee(
      color: kPrimaryColor,
      fontSize: size.width * 0.07,
      fontWeight: FontWeight.bold);

  TextStyle get letra2GD => GoogleFonts.aBeeZee(
        color: kTerciaryColor,
        fontSize: size.width * 0.05,
        // fontWeight: FontWeight.bold
      );

  // READ:  SCREEN MAPA LETTER

  TextStyle get letra1Mapa => GoogleFonts.aBeeZee(
      color: kPrimaryColor,
      fontSize: size.width * 0.05,
      fontWeight: FontWeight.bold);

  TextStyle get letra2Mapa => GoogleFonts.aBeeZee(
      color: Colors.black,
      fontSize: size.width * 0.045,
      fontWeight: FontWeight.bold);

  TextStyle get letra3Mapa => GoogleFonts.aBeeZee(
        color: Colors.black,
        fontSize: size.width * 0.04,
        // fontWeight: FontWeight.bold
      );

  TextStyle get letra4Mapa => GoogleFonts.aBeeZee(
      color: Colors.white,
      fontSize: size.width * 0.05,
      fontWeight: FontWeight.bold);

  TextStyle get letra5Mapa => GoogleFonts.aBeeZee(
      color: Colors.white,
      fontSize: size.width * 0.035,
      fontWeight: FontWeight.bold);
}
