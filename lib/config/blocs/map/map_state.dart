part of 'map_bloc.dart';

enum MapGoogleStatus { loaded, processing, error }

enum DetailMapGoogle { hybrid, none, normal, satellite, terrain }

enum DetailSanCruz { marcadores, distritos, zonas, todos }

enum ReportMainCategory {
  delitos,
  ordenPublico,
  emergencias,
  reporteComunitario,
  accidentes,
  otros,
}

// Subcategorías específicas de reportes
enum ReportSubcategory {
  // Delitos
  robo, // Robo
  hurto, // Hurto
  asalto, // Asalto
  violenciaFamiliar, // Violencia familiar/doméstica
  extorsion, // Extorsión
  secuestro, // Secuestro
  homicidio, // Homicidio
  violacionSexual, // Violación sexual
  acoso, // Acoso
  estafa, // Estafa
  fraudeBancario, // Fraude bancario
  violenciaGenero, // Violencia de género
  maltratoInfantil, // Maltrato infantil
  amenazas, // Amenazas
  suicidio, // Intento de suicidio

  // Orden Público
  vandalismo, // Vandalismo
  disturbioPublico, // Disturbios en vía pública
  establecimientoIrregular, // Locales irregulares
  alcoholismo, // Consumo de alcohol en vía pública
  drogadiccion, // Drogas en vía pública
  prostitucion, // Prostitución
  pandillaje, // Pandillaje
  invasionPropiedad, // Invasión de propiedad
  ventaIlegal, // Venta ilegal de productos
  alteracionOrden, // Alteración del orden público
  manifestacionIlegal, // Manifestación no autorizada

  // Emergencias
  incendio, // Incendios
  emergenciaMedica, // Emergencias médicas
  desastreNatural, // Desastres naturales
  personaExtraviada, // Persona extraviada
  fugaGas, // Fuga de gas
  colapsoEstructura, // Colapso de estructura
  inundacion, // Inundación
  explosionIncidente, // Explosión/incidente con explosivos
  rescatePersona, // Rescate de persona
  materialPeligroso, // Incidente con material peligroso

  // Accidentes
  accidenteConstruccion, // Accidente en construcción
  accidenteLaboral, // Accidente laboral
  accidenteElectrico, // Accidente eléctrico
  caidaAltura, // Caída de altura
  quemaduras, // Accidente con quemaduras
  intoxicacion, // Intoxicación
  ahogamiento, // Ahogamiento
  accidenteDeportivo, // Accidente deportivo

  // Reportes Comunitarios
  ruidoMolesto, // Ruidos molestos
  comercioInformal, // Comercio informal
  basuraAcumulada, // Acumulación de basura
  indigencia, // Personas en situación de calle
  grafitis, // Grafitis/pintas
  peleasCallejeras, // Peleas en la vía pública
  abandonoAnimales, // Abandono de animales
  maltratoAnimal, // Maltrato animal
  contaminacionAmbiental, // Contaminación ambiental
  obstruccionVia, // Obstrucción de vía pública
  danosPropiedad, // Daños a la propiedad pública
  actividadSospechosa, // Actividad sospechosa

  // Otros
  otros, // Otros tipos no categorizados
}

class MapState extends Equatable {
  // LOGIC : Control del zoom
  final double statusZoom;

  final bool processMap;
  final bool isMapInitialized;
  final bool followUser;

  final Map<String, Marker> originales;
  final Map<String, Marker> markers;
  final Map<String, Polyline> polylines;
  final Map<String, Polygon> polygons;

  final MapGoogleStatus statusMap;

  // LOGIC : CONTROL DE MAPA
  final DetailMapGoogle detailMapGoogle;
  final DetailSanCruz detailSanCruz;
  final ReportMainCategory reportMainCategory;

  MapState(
      {this.statusZoom = 17,
      this.processMap = true,
      this.isMapInitialized = false,
      this.statusMap = MapGoogleStatus.loaded,
      this.followUser = false,
      Map<String, Marker>? markers,
      Map<String, Marker>? originales,
      Map<String, Polyline>? polylines,
      Map<String, Polygon>? polygons,
      // LOGIC : CONTROL DE MAPA
      this.detailMapGoogle = DetailMapGoogle.normal,
      this.detailSanCruz = DetailSanCruz.todos,
      this.reportMainCategory = ReportMainCategory.delitos})
      : markers = markers ?? const {},
        polylines = polylines ?? const {},
        originales = originales ?? const {},
        polygons = polygons ?? const {};

  MapState copyWith({
    double? statusZoom,
    bool? processMap,
    bool? isMapInitialized,
    bool? followUser,
    Map<String, Marker>? markers,
    Map<String, Marker>? originales,
    Map<String, Polyline>? polylines,
    Map<String, Polygon>? polygons,
    MapGoogleStatus? statusMap,
    DetailMapGoogle? detailMapGoogle,
    DetailSanCruz? detailSanCruz,
    ReportMainCategory? reportMainCategory,
  }) {
    return MapState(
      statusZoom: statusZoom ?? this.statusZoom,
      processMap: processMap ?? this.processMap,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      originales: originales ?? this.originales,
      polygons: polygons ?? this.polygons,
      statusMap: statusMap ?? this.statusMap,
      // LOGIC : CONTROL DE MAPA
      detailMapGoogle: detailMapGoogle ?? this.detailMapGoogle,
      detailSanCruz: detailSanCruz ?? this.detailSanCruz,
      reportMainCategory: reportMainCategory ?? this.reportMainCategory,
    );
  }

  @override
  List<Object?> get props => [
        statusZoom,
        processMap,
        isMapInitialized,
        followUser,
        markers,
        polylines,
        polygons,
        statusMap,
        originales,
        // LOGIC : CONTROL DE MAPA
        detailMapGoogle,
        detailSanCruz,
        reportMainCategory,
      ];
}
