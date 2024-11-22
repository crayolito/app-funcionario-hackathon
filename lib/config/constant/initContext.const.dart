import 'package:app_sw1final/config/constant/letterStyle.const.dart';
import 'package:flutter/material.dart';

class InitContext {
  static InitContext? _instance;
  late LetterStyle estiloLetras;

  InitContext._();

  static Size get size {
    if (_instance == null) {
      throw Exception("InitContext no inicializado");
    }
    return _instance!.estiloLetras.size;
  }

  static LetterStyle get letterStyle {
    if (_instance == null) {
      throw Exception("InitContext no inicializado");
    }
    return _instance!.estiloLetras;
  }

  static void inicializar(BuildContext context) {
    _instance ??= InitContext._()..estiloLetras = LetterStyle(context);
  }

  static InitContext get instance {
    if (_instance == null) {
      throw Exception("InitContext no inicializado");
    }
    return _instance!;
  }
}
