import 'dart:async';
import 'dart:math' as math;
import 'dart:math';

import 'package:app_sw1final/config/blocs/map/helpers.map.dart';
import 'package:app_sw1final/config/constant/colors.const.dart';
import 'package:app_sw1final/config/constant/data.const.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart' as xml;

part 'map_event.dart';
part 'map_state.dart';

enum ZoomLevel { all, main, minimal, distant }

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
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

  double? _lastZoomLevel;
  DateTime? _lastUpdate;

  MapBloc() : super(MapState()) {
    on<OnMapInitContent>((event, emit) async {
      // READ : POLIGONOS
      List<List<LatLng>> listPolygons = [];

      // Generar niveles de peligrosidad para cada zona
      List<int> zoneDangerLevels =
          _generateZoneDangerLevels(zonasPuntos.length);

      for (int i = 0; i < zonasPuntos.length; i++) {
        List<LatLng> polygonPoints = generarPoligonoEnvolvente(
          zonasPuntos[i],
          metrosDesviacion: 20, // 200 metros extra de margen
          numeroPuntos: 20, // Número de puntos del polígono
        );

        listPolygons.add(polygonPoints);
      }

      Map<String, Polygon> polygons = listPolygons.asMap().map((index, points) {
        // Obtener color y opacidad basados en el nivel de peligrosidad
        final (color, opacity) = _getDangerZoneStyle(zoneDangerLevels[index]);

        return MapEntry(
          'zona_$index',
          Polygon(
            polygonId: PolygonId('zona_$index'),
            points: points,
            strokeWidth: 2,
            strokeColor: kPrimaryColor,
            fillColor: color.withOpacity(opacity),
            consumeTapEvents: true,
            geodesic: true,
          ),
        );
      });

      // READ : MARCADORES
      Map<String, Marker> markers = {};
      for (int i = 0; i < zonasPuntos.length; i++) {
        for (int j = 0; j < zonasPuntos[i].length; j++) {
          final icon = await HelpersMap.getAssetImageMarker(
              obtenerRutaIcono(Random().nextInt(6)));
          markers['marker_${i}_$j'] = Marker(
            markerId: MarkerId('marker_${i}_$j'),
            position: zonasPuntos[i][j],
            icon: icon,
            infoWindow: InfoWindow(title: 'Punto $j'),
          );
        }
      }

      emit(state.copyWith(
          polygons: polygons, markers: markers, originales: markers));
    });

    on<OnCameraPosition>((event, emit) async {
      final currentTime = DateTime.now();
      final currentZoom = event.cameraPosition.zoom;

      // Control de actualizaciones para rendimiento óptimo
      if (_shouldSkipUpdate(currentTime, currentZoom)) return;

      _lastZoomLevel = currentZoom;
      _lastUpdate = currentTime;
      cameraPosition = event.cameraPosition;

      final Map<String, Marker> currentMarkers = state.originales;
      final Map<String, Marker> visibleMarkers = {};

      // Aplicar filtros según nivel de zoom
      await _filterMarkersByZoomLevel(
        currentZoom: currentZoom,
        sourceMarkers: currentMarkers,
        targetMarkers: visibleMarkers,
      );

      if (visibleMarkers.isNotEmpty) {
        emit(state.copyWith(
          markers: visibleMarkers,
        ));
      }
    });

    on<OnChangeDetailMapGoogle>((event, emit) {
      emit(state.copyWith(detailMapGoogle: event.detail));
    });

    on<OnChangeDetailSantaCruz>((event, emit) async {
      if (event.detail == DetailSanCruz.zonas) {
        // READ : POLIGONOS
        List<List<LatLng>> listPolygons = [];

        // Generar niveles de peligrosidad para cada zona
        List<int> zoneDangerLevels =
            _generateZoneDangerLevels(zonasPuntos.length);

        for (int i = 0; i < zonasPuntos.length; i++) {
          List<LatLng> polygonPoints = generarPoligonoEnvolvente(
            zonasPuntos[i],
            metrosDesviacion: 20, // 200 metros extra de margen
            numeroPuntos: 20, // Número de puntos del polígono
          );

          listPolygons.add(polygonPoints);
        }

        Map<String, Polygon> polygons =
            listPolygons.asMap().map((index, points) {
          // Obtener color y opacidad basados en el nivel de peligrosidad
          final (color, opacity) = _getDangerZoneStyle(zoneDangerLevels[index]);

          return MapEntry(
            'zona_$index',
            Polygon(
              polygonId: PolygonId('zona_$index'),
              points: points,
              strokeWidth: 2,
              strokeColor: kPrimaryColor,
              fillColor: color.withOpacity(opacity),
              consumeTapEvents: true,
              geodesic: true,
            ),
          );
        });

        emit(state.copyWith(polygons: polygons));
        return;
      }

      if (event.detail == DetailSanCruz.distritos) {
        List<String> distritosKML = [
          "assets/kmls/d_1.kml",
          "assets/kmls/d_2.kml",
          "assets/kmls/d_3.kml",
          "assets/kmls/d_4.kml",
          "assets/kmls/d_6_14.kml",
          "assets/kmls/d_7_15.kml",
          "assets/kmls/d_8.kml",
          "assets/kmls/d_9.kml",
          "assets/kmls/d_10.kml",
          "assets/kmls/d_11.kml",
          "assets/kmls/d_12.kml",
          "assets/kmls/d_16.kml",
        ];

        try {
          Map<String, Polygon> allPolygons = {};

          // Cargar cada KML con un índice y color único
          for (int i = 0; i < distritosKML.length; i++) {
            Map<String, Polygon> polygons = await loadKML(distritosKML[i], i);
            allPolygons.addAll(polygons);
          }

          emit(state.copyWith(
            polygons: allPolygons,
          ));
          return;
        } catch (e) {
          print('Error al cargar los KMLs: $e');
        }
      }
    });

    on<OnGoogleMapController>((event, emit) {
      mapController = event.controller;
    });
  }

  static Future<Map<String, Polygon>> loadKML(
      String direction, int index) async {
    try {
      String kmlString = await rootBundle.loadString(direction);
      final document = xml.XmlDocument.parse(kmlString);
      Map<String, Polygon> polygons = {};
      List<LatLng> polygonCoordinates = [];

      // Obtener todos los puntos del KML
      document.findAllElements('Point').forEach((pointElement) {
        var coordElement = pointElement.findElements('coordinates').first;
        String coordinates = coordElement.text.trim();
        List<String> coords = coordinates.split(',');

        if (coords.length >= 2) {
          double lng = double.parse(coords[0]);
          double lat = double.parse(coords[1]);
          polygonCoordinates.add(LatLng(lat, lng));
        }
      });

      // Si hay puntos, crear el polígono
      if (polygonCoordinates.isNotEmpty) {
        // Agregar el primer punto al final para cerrar el polígono si es necesario
        if (polygonCoordinates.first != polygonCoordinates.last) {
          polygonCoordinates.add(polygonCoordinates.first);
        }

        String districtId = "Distrito$index";
        polygons[districtId] = Polygon(
          polygonId: PolygonId(districtId),
          points: polygonCoordinates,
          fillColor: const Color(0xFF231F20).withOpacity(0.30),
          strokeColor: const Color(0xFF1B8206),
          strokeWidth: 4,
          geodesic: true,
        );
      }

      return polygons;
    } catch (e) {
      print('Error loading KML: $e');
      return {};
    }
  }

  // Función para determinar si un punto es principal
  bool _isMainPoint(String markerId) {
    // Aquí puedes implementar tu lógica para determinar
    // si un marcador es principal (por ejemplo, basado en su ID)
    return markerId.endsWith(
        '_0'); // Ejemplo: considera principales los primeros puntos de cada zona
  }

  String obtenerRutaIcono(int numero) {
    switch (numero) {
      case 1:
        return 'assets/delitos.png';
      case 2:
        return 'assets/ordenPublico.png';
      case 3:
        return 'assets/emergencias.png';
      case 4:
        return 'assets/reporteComunitario.png';
      case 5:
        return 'assets/accidentes.png';
      case 6:
        return 'assets/otros.png';
      default:
        return 'assets/otros.png';
    }
  }

  List<LatLng> generarPoligonoEnvolvente(
    List<LatLng> puntosBase, {
    required double metrosDesviacion,
    required int numeroPuntos,
  }) {
    if (puntosBase.length < 3) return puntosBase;

    // Encontrar el centro
    double sumLat = 0, sumLng = 0;
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    // Calcular centro y límites
    for (var punto in puntosBase) {
      sumLat += punto.latitude;
      sumLng += punto.longitude;
      minLat = math.min(minLat, punto.latitude);
      maxLat = math.max(maxLat, punto.latitude);
      minLng = math.min(minLng, punto.longitude);
      maxLng = math.max(maxLng, punto.longitude);
    }

    LatLng centro =
        LatLng(sumLat / puntosBase.length, sumLng / puntosBase.length);

    // Calcular radio máximo
    double radio = math.max(
          (maxLat - minLat) / 2,
          (maxLng - minLng) / 2,
        ) *
        1.2; // Factor de expansión de 20%

    // Convertir metros a grados (aproximación)
    double desviacionGrados = metrosDesviacion / 111111;
    radio += desviacionGrados;

    // Generar puntos del polígono
    List<LatLng> poligono = [];
    for (int i = 0; i <= numeroPuntos; i++) {
      double angulo = (2 * math.pi * i) / numeroPuntos;
      double latitud = centro.latitude + radio * math.sin(angulo);
      double longitud = centro.longitude +
          radio * math.cos(angulo) / math.cos(centro.latitude * math.pi / 180);
      poligono.add(LatLng(latitud, longitud));
    }

    return poligono;
  }

  bool _shouldSkipUpdate(DateTime currentTime, double currentZoom) {
    if (_lastUpdate != null &&
        currentTime.difference(_lastUpdate!).inMilliseconds < DEBOUNCE_TIME) {
      return true;
    }

    if (_lastZoomLevel != null &&
        (currentZoom - _lastZoomLevel!).abs() < MIN_ZOOM_CHANGE) {
      return true;
    }

    return false;
  }

  Future<void> _filterMarkersByZoomLevel({
    required double currentZoom,
    required Map<String, Marker> sourceMarkers,
    required Map<String, Marker> targetMarkers,
  }) async {
    if (currentZoom >= ZOOM_STREET) {
      // Vista de calle: Todos los marcadores con máxima visibilidad
      targetMarkers.addAll(await _enhanceMarkers(sourceMarkers, 1.0, true));
      return;
    }

    final Set<String> processedZones = {};
    final markerEntries = sourceMarkers.entries.toList();
    final Map<String, List<Marker>> zoneMarkers = {};

    // Agrupar marcadores por zona
    for (final entry in markerEntries) {
      final parts = entry.key.split('_');
      if (parts.length < 3) continue;

      final zoneId = parts[1];
      if (!zoneMarkers.containsKey(zoneId)) {
        zoneMarkers[zoneId] = [];
      }
      zoneMarkers[zoneId]!.add(entry.value);
    }

    // Aplicar filtros según nivel de zoom
    for (final zoneId in zoneMarkers.keys) {
      final markers = zoneMarkers[zoneId]!;
      final zoneIndex = int.tryParse(zoneId) ?? -1;

      if (currentZoom >= ZOOM_DETAILED) {
        // Vista detallada: Mayoría de los marcadores
        for (var i = 0; i < markers.length; i++) {
          if (i % 2 == 0) {
            targetMarkers['marker_${zoneId}_$i'] =
                await _createEnhancedMarker(markers[i], 1.0, true);
          }
        }
      } else if (currentZoom >= ZOOM_LOCAL) {
        // Vista local: Marcadores importantes
        for (var i = 0; i < markers.length; i += 3) {
          targetMarkers['marker_${zoneId}_$i'] =
              await _createEnhancedMarker(markers[i], 0.95, true);
        }
      } else if (currentZoom >= ZOOM_NEIGHBORHOOD) {
        // Vista de vecindario: Puntos principales
        for (var i = 0; i < markers.length; i += 4) {
          if (zoneIndex % 2 == 0 || i == 0) {
            targetMarkers['marker_${zoneId}_$i'] =
                await _createEnhancedMarker(markers[i], 0.9);
          }
        }
      } else if (currentZoom >= ZOOM_DISTRICT) {
        // Vista de distrito: Representantes de zona
        if (!processedZones.contains(zoneId) && markers.isNotEmpty) {
          targetMarkers['marker_${zoneId}_0'] =
              await _createEnhancedMarker(markers.first, 0.85);
          processedZones.add(zoneId);
        }
      } else if (currentZoom >= ZOOM_CITY) {
        // Vista de ciudad: Marcadores selectos
        if (zoneIndex % 3 == 0 && markers.isNotEmpty) {
          targetMarkers['marker_${zoneId}_0'] =
              await _createEnhancedMarker(markers.first, 0.8);
        }
      } else if (currentZoom >= ZOOM_REGION) {
        // Vista regional: Muy pocos marcadores
        if (zoneIndex % 4 == 0 && markers.isNotEmpty) {
          targetMarkers['marker_${zoneId}_0'] =
              await _createEnhancedMarker(markers.first, 0.75);
        }
      } else {
        // Vista lejana: Mínimo de marcadores
        if (zoneIndex < 3 && markers.isNotEmpty) {
          targetMarkers['marker_${zoneId}_0'] =
              await _createEnhancedMarker(markers.first, 0.7);
        }
      }
    }
  }

  Future<Map<String, Marker>> _enhanceMarkers(
      Map<String, Marker> markers, double opacity, bool isDetailed) async {
    Map<String, Marker> enhanced = {};
    for (var entry in markers.entries) {
      enhanced[entry.key] =
          await _createEnhancedMarker(entry.value, opacity, isDetailed);
    }
    return enhanced;
  }

  Future<Marker> _createEnhancedMarker(Marker originalMarker, double opacity,
      [bool isDetailed = false]) async {
    return originalMarker.copyWith(
      alphaParam: opacity,
      zIndexParam: opacity * 10,
      visibleParam: true,
      // Ajustar tamaño según nivel de detalle
    );
  }

  String _getZoomLevelDescription(double zoom) {
    if (zoom >= ZOOM_STREET) return 'Calle';
    if (zoom >= ZOOM_DETAILED) return 'Detallada';
    if (zoom >= ZOOM_LOCAL) return 'Local';
    if (zoom >= ZOOM_NEIGHBORHOOD) return 'Vecindario';
    if (zoom >= ZOOM_DISTRICT) return 'Distrito';
    if (zoom >= ZOOM_CITY) return 'Ciudad';
    if (zoom >= ZOOM_REGION) return 'Región';
    if (zoom >= ZOOM_STATE) return 'Estado';
    return 'Vista lejana';
  }

  // Genera niveles de peligrosidad para cada zona
  List<int> _generateZoneDangerLevels(int numZones) {
    List<int> levels = [];
    for (int i = 0; i < numZones; i++) {
      // Aquí puedes implementar tu propia lógica para determinar el nivel
      // Por ahora usamos una distribución aleatoria ponderada
      final random = Random();
      final value = random.nextDouble();

      if (value < 0.1) {
        levels.add(DANGER_CRITICAL); // 10% zonas críticas
      } else if (value < 0.25) {
        levels.add(DANGER_HIGH); // 15% zonas altas
      } else if (value < 0.5) {
        levels.add(DANGER_MEDIUM); // 25% zonas medias
      } else if (value < 0.8) {
        levels.add(DANGER_LOW); // 30% zonas bajas
      } else {
        levels.add(DANGER_MINIMAL); // 20% zonas mínimas
      }
    }
    return levels;
  }

  // Retorna el color y opacidad según el nivel de peligrosidad
  (Color, double) _getDangerZoneStyle(int dangerLevel) {
    switch (dangerLevel) {
      case DANGER_CRITICAL:
        return (
          Color(0xFFDC2626), // Rojo intenso
          0.30, // Mayor opacidad para zonas críticas
        );
      case DANGER_HIGH:
        return (
          Color(0xFFF97316), // Naranja intenso
          0.30,
        );
      case DANGER_MEDIUM:
        return (
          Color(0xFFFACC15), // Amarillo
          0.30,
        );
      case DANGER_LOW:
        return (
          Color(0xFF22C55E), // Verde
          0.30,
        );
      case DANGER_MINIMAL:
        return (
          Color(0xFF3B82F6), // Azul
          0.30, // Menor opacidad para zonas seguras
        );
      default:
        return (
          Color(0xFF6B7280), // Gris por defecto
          0.30,
        );
    }
  }

  // Retorna una descripción del nivel de peligrosidad
  String _getDangerLevelDescription(int dangerLevel) {
    switch (dangerLevel) {
      case DANGER_CRITICAL:
        return 'Zona de Alto Riesgo';
      case DANGER_HIGH:
        return 'Zona de Riesgo Elevado';
      case DANGER_MEDIUM:
        return 'Zona de Riesgo Moderado';
      case DANGER_LOW:
        return 'Zona de Bajo Riesgo';
      case DANGER_MINIMAL:
        return 'Zona Segura';
      default:
        return 'Nivel de Riesgo No Determinado';
    }
  }

  Future<void> reorientarPosicion(LatLng posicion) async {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: posicion,
          zoom: 18,
        ),
      ));
    }
  }
}
