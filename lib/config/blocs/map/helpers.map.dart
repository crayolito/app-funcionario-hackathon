import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HelpersMap {
  // Niveles de zoom más granulares para mejor control
  static const double ZOOM_STREET = 18.0; // Vista a nivel de calle
  static const double ZOOM_DETAILED = 16.0; // Vista detallada
  static const double ZOOM_LOCAL = 14.5; // Vista local
  static const double ZOOM_NEIGHBORHOOD = 13.0; // Vista de vecindario
  static const double ZOOM_DISTRICT = 11.5; // Vista de distrito
  static const double ZOOM_CITY = 10.0; // Vista de ciudad
  static const double ZOOM_REGION = 8.5; // Vista regional
  static const double ZOOM_STATE = 7.0; // Vista estatal

  // Umbrales de control optimizados
  static const double MIN_ZOOM_CHANGE = 0.2; // Más sensible a cambios
  static const int DEBOUNCE_TIME = 80; // Respuesta más rápida

  // Constantes para niveles de peligrosidad
  static const int DANGER_CRITICAL = 4; // Rojo
  static const int DANGER_HIGH = 3; // Naranja
  static const int DANGER_MEDIUM = 2; // Amarillo
  static const int DANGER_LOW = 1; // Verde
  static const int DANGER_MINIMAL = 0; // Azul

  static Future<BitmapDescriptor> getAssetImageMarker(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);

    // Decodificar la imagen primero para obtener sus dimensiones originales
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo fi = await codec.getNextFrame();

    // Calcular las dimensiones manteniendo la proporción
    final double aspectRatio = fi.image.width / fi.image.height;
    int targetWidth = 140;
    int targetHeight = (targetWidth / aspectRatio).round();

    // Crear la imagen redimensionada
    final imageCodec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: targetHeight,
      targetWidth: targetWidth,
      allowUpscaling: false,
    );

    final frame = await imageCodec.getNextFrame();
    final imageData = await frame.image.toByteData(
      format: ui.ImageByteFormat.png, // PNG para mejor calidad sin pérdida
    );

    return BitmapDescriptor.fromBytes(imageData!.buffer.asUint8List());
  }

  static Future<BitmapDescriptor> getNetworkImageMarker(
      String urlMarker) async {
    final resp = await Dio().get(
      urlMarker,
      options: Options(responseType: ResponseType.bytes),
    );

    final imageCodec = await ui.instantiateImageCodec(resp.data,
        targetHeight: 140, targetWidth: 140);
    final frame = await imageCodec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
