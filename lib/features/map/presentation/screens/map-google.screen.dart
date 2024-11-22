import 'package:animate_do/animate_do.dart';
import 'package:app_sw1final/config/blocs/auth/auth_bloc.dart';
import 'package:app_sw1final/config/blocs/map/map_bloc.dart';
import 'package:app_sw1final/config/blocs/permissions/permission_bloc.dart';
import 'package:app_sw1final/config/constant/colors.const.dart';
import 'package:app_sw1final/config/constant/sizes.const.dart';
import 'package:app_sw1final/features/map/presentation/screens/map-loading.screen.dart';
import 'package:app_sw1final/features/map/presentation/widgets/map-google.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGoogleScreen extends StatefulWidget {
  const MapGoogleScreen({super.key});

  @override
  State<MapGoogleScreen> createState() => _MapGoogleScreenState();
}

class _MapGoogleScreenState extends State<MapGoogleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initLocation();
  }

  Future<void> _initLocation() async {
    final permissionBloc = BlocProvider.of<PermissionBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.add(const OnMapInitContent());
    await permissionBloc.getActualPosition();
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, locationState) {
      if (locationState.lastKnownLocation == null) {
        return const MapLoading();
      }
      return Stack(
        children: [
          BlocBuilder<MapBloc, MapState>(builder: (context, mapGoogleState) {
            return MapViewGoogleMap(
                initialLocation: LatLng(
                    locationState.lastKnownLocation!.latitude,
                    locationState.lastKnownLocation!.longitude),
                polygons: mapGoogleState.polygons.values.toSet(),
                polylines: mapGoogleState.polylines.values.toSet(),
                markers: mapGoogleState.markers.values.toSet());
          })
          // READ : OPCIONES DEL MAPA
          ,
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.01,
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      top: size.height * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.90),
                      onPressed: () {
                        mapBloc.add(const OnChangeDetailSantaCruz(
                            DetailSanCruz.distritos));
                      },
                      child: Icon(
                        FontAwesomeIcons.locationCrosshairs,
                        color: kPrimaryColor,
                        size: size.width * 0.06,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      top: size.height * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.90),
                      onPressed: () {},
                      child: Icon(
                        FontAwesomeIcons.locationArrow,
                        color: kPrimaryColor,
                        size: size.width * 0.06,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      top: size.height * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.90),
                      onPressed: () {},
                      child: Icon(
                        FontAwesomeIcons.rotate,
                        color: kPrimaryColor,
                        size: size.width * 0.06,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      top: size.height * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.90),
                      onPressed: () {},
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: kPrimaryColor,
                        size: size.width * 0.06,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      top: size.height * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.90),
                      onPressed: () {},
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: kPrimaryColor,
                        size: size.width * 0.06,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.01,
                      top: size.height * 0.01,
                      right: size.width * 0.01,
                    ),
                    child: FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.90),
                      onPressed: () async {
                        await showSettingsDialog(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.layerGroup,
                        color: kPrimaryColor,
                        size: size.width * 0.06,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          // READ : SEARCH BAR
          ,
          const IconCustomSearch(),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return authState.viewInfoDetails
                  ? FadeInRight(child: const DangerZoneDetailView())
                  : const IconMenuCustomDetail();
            },
          ),

          // READ : SEARCH LIST DE DISTRITOS
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState.viewInfoSearch) {
                return FadeInUp(child: const WindowViewDistritos());
              }
              return Container();
            },
          ),
          // READ : CAPAS DE MAPA
        ],
      );
    });
  }

  Future<void> showSettingsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.width * 0.03),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: size.width * 0.85,
          height: size.height * 0.45,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(size.width * 0.03),
            boxShadow: [
              BoxShadow(
                color: kTerciaryColor.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const SettingsDialogContent(),
        ),
      ),
    );
  }
}

class SettingsDialogContent extends StatefulWidget {
  const SettingsDialogContent({Key? key}) : super(key: key);

  @override
  State<SettingsDialogContent> createState() => _SettingsDialogContentState();
}

class _SettingsDialogContentState extends State<SettingsDialogContent> {
  DetailMapGoogle selectedMapType = DetailMapGoogle.normal;
  DetailSanCruz selectedDetail = DetailSanCruz.marcadores;
  ReportMainCategory selectedCategory = ReportMainCategory.delitos;

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context, listen: true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(size.width * 0.01)),
          ),
          child: Center(
            child: Text('Configuración', style: letterStyle.letra4Mapa),
          ),
        ),
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Tipo de Mapa', Icons.map),
                _buildOptionsContainer(
                  DetailMapGoogle.values
                      .map(
                        (type) => _buildCustomRadioTile<DetailMapGoogle>(
                          value: type,
                          groupValue: selectedMapType,
                          title: _getMapTypeText(type),
                          onChanged: (value) {
                            setState(() => selectedMapType = value!);
                            mapBloc.add(OnChangeDetailMapGoogle(value!));
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Detalles de Mapa', Icons.layers),
                _buildOptionsContainer(
                  DetailSanCruz.values
                      .map(
                        (detail) => _buildCustomRadioTile<DetailSanCruz>(
                          value: detail,
                          groupValue: selectedDetail,
                          title: _getDetailText(detail),
                          onChanged: (value) {
                            setState(() => selectedDetail = value!);
                            mapBloc.add(OnChangeDetailSantaCruz(value!));
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Tipos de Reportes', Icons.report_problem),
                _buildOptionsContainer(
                  ReportMainCategory.values
                      .map(
                        (category) => _buildCustomRadioTile<ReportMainCategory>(
                          value: category,
                          groupValue: selectedCategory,
                          title: _getCategoryText(category),
                          onChanged: (value) {
                            setState(() => selectedCategory = value!);
                            mapBloc.add(OnChangeReportMainCategory(value!));
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        // Footer
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: kCuartoColor.withOpacity(0.1),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: kSecondaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Cerrar',
                  style: letterStyle.letra5Mapa,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: kPrimaryColor, size: 20),
          const SizedBox(width: 8),
          Text(title, style: letterStyle.letra2Mapa),
        ],
      ),
    );
  }

  Widget _buildOptionsContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: kCuartoColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildCustomRadioTile<T>({
    required T value,
    required T groupValue,
    required String title,
    required ValueChanged<T?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kCuartoColor.withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? kPrimaryColor : kCuartoColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                fontSize: size.width * 0.04,
                color: isSelected ? kPrimaryColor : kTerciaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMapTypeText(DetailMapGoogle type) {
    switch (type) {
      case DetailMapGoogle.hybrid:
        return 'Híbrido';
      case DetailMapGoogle.none:
        return 'Ninguno';
      case DetailMapGoogle.normal:
        return 'Normal';
      case DetailMapGoogle.satellite:
        return 'Satélite';
      case DetailMapGoogle.terrain:
        return 'Terreno';
    }
  }

  String _getDetailText(DetailSanCruz detail) {
    switch (detail) {
      case DetailSanCruz.marcadores:
        return 'Marcadores';
      case DetailSanCruz.distritos:
        return 'Distritos';
      case DetailSanCruz.zonas:
        return 'Zonas';
      case DetailSanCruz.todos:
        return 'Todos';
    }
  }

  String _getCategoryText(ReportMainCategory category) {
    switch (category) {
      case ReportMainCategory.delitos:
        return 'Delitos';
      case ReportMainCategory.ordenPublico:
        return 'Orden Público';
      case ReportMainCategory.emergencias:
        return 'Emergencias';
      case ReportMainCategory.reporteComunitario:
        return 'Reporte Comunitario';
      case ReportMainCategory.accidentes:
        return 'Accidentes';
      case ReportMainCategory.otros:
        return 'Otros';
    }
  }
}

class WindowViewDistritos extends StatelessWidget {
  const WindowViewDistritos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> distritos = [
      {
        "nombre": "Distrito 1",
        "detalles": {"titulo": "Equipetrol", "subtitulo1": "Zona Norte"}
      },
      {
        "nombre": "Distrito 2",
        "detalles": {"titulo": "Plan 3000", "subtitulo1": "Zona Sur"}
      },
      {
        "nombre": "Distrito 3",
        "detalles": {"titulo": "Villa 1ro de Mayo", "subtitulo1": "Zona Este"}
      },
      {
        "nombre": "Distrito 4",
        "detalles": {"titulo": "Urbarí", "subtitulo1": "Zona Central"}
      },
      {
        "nombre": "Distrito 5",
        "detalles": {"titulo": "Santos Dumont", "subtitulo1": "Zona Norte"}
      },
      {
        "nombre": "Distrito 6",
        "detalles": {"titulo": "El Bajío", "subtitulo1": "Zona Oeste"}
      },
      {
        "nombre": "Distrito 7",
        "detalles": {"titulo": "Pampa de la Isla", "subtitulo1": "Zona Este"}
      },
      {
        "nombre": "Distrito 8",
        "detalles": {"titulo": "Villa Warnes", "subtitulo1": "Zona Norte"}
      },
      {
        "nombre": "Distrito 9",
        "detalles": {"titulo": "Palmasola", "subtitulo1": "Zona Oeste"}
      },
      {
        "nombre": "Distrito 10",
        "detalles": {"titulo": "Los Lotes", "subtitulo1": "Zona Sur"}
      },
      {
        "nombre": "Distrito 11",
        "detalles": {"titulo": "Los Chacos", "subtitulo1": "Zona Este"}
      },
      {
        "nombre": "Distrito 12",
        "detalles": {"titulo": "El Trompillo", "subtitulo1": "Zona Central"}
      },
      {
        "nombre": "Distrito 13",
        "detalles": {"titulo": "Las Pampitas", "subtitulo1": "Zona Sur"}
      },
      {
        "nombre": "Distrito 14",
        "detalles": {"titulo": "Los Pozos", "subtitulo1": "Zona Norte"}
      },
      {
        "nombre": "Distrito 15",
        "detalles": {"titulo": "Guapilo", "subtitulo1": "Zona Este"}
      },
      {
        "nombre": "Distrito 16",
        "detalles": {"titulo": "Cambodromo", "subtitulo1": "Zona Oeste"}
      }
    ];

    final decoration3 = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(size.width * 0.03),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        )
      ],
      border: Border.all(
        color: kPrimaryColor,
        width: 2,
      ),
    );

    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Material(
            color: Colors.transparent,
            child: Container(
              height: size.height * 0.9,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * 0.02),
                      topRight: Radius.circular(size.width * 0.02))),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.width * 0.1),
                      child: Container(
                          padding: EdgeInsets.only(top: size.width * 0.09),
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                            border: const Border(
                              top: BorderSide(
                                color: kPrimaryColor,
                                width: 8,
                              ),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: -2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.width * 0.05),
                                topRight: Radius.circular(size.width * 0.05)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.015),
                                // color: Colors.amber,
                                width: size.width,
                                height: size.height * 0.07,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: size.width * 0.3,
                                        ),
                                        decoration: decoration3,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.025),
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .magnifyingGlass,
                                                color: kPrimaryColor,
                                                size: size.width * 0.055,
                                              ),
                                            ),
                                            Expanded(
                                              child: TextField(
                                                textAlign: TextAlign.left,
                                                decoration: InputDecoration(
                                                  hintText: 'Buscar...',
                                                  hintStyle:
                                                      letterStyle.letra3Mapa,
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: size.width *
                                                              0.02),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Icono de configuración
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.02),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: kPrimaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.03),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                          )
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(
                                          FontAwesomeIcons.filePen,
                                          color: kPrimaryColor,
                                          size: size.width * 0.055,
                                        ),
                                        onPressed: () {
                                          context.push('/generarReporte');
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // READ : ELEMENTOS
                              Container(
                                margin: EdgeInsets.only(top: size.width * 0.02),
                                width: size.width,
                                height: size.height * 0.855,
                                color: Colors.white,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: distritos.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        final mapBloc =
                                            BlocProvider.of<MapBloc>(context);
                                        mapBloc.reorientarPosicion(
                                            distritos[index]['nombre']);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.03,
                                          vertical: 12,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: kPrimaryColor
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .locationDot,
                                                    color: kPrimaryColor,
                                                    size: size.width * 0.06,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          size.width * 0.03,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              distritos[index]
                                                                  ['nombre'],
                                                              style: letterStyle
                                                                  .letra1Mapa,
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    size.width *
                                                                        0.02),
                                                            Text(
                                                              '- ${distritos[index]['detalles']['titulo']}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: letterStyle
                                                                  .letra2Mapa,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: size.width *
                                                                0.01),
                                                        Text(
                                                          distritos[index]
                                                                  ['detalles']
                                                              ['subtitulo1'],
                                                          style: letterStyle
                                                              .letra3Mapa,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: IconButton(
                                                    icon: FaIcon(
                                                      FontAwesomeIcons
                                                          .locationArrow,
                                                      color: Colors.black,
                                                      size: size.width * 0.05,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (index < distritos.length - 1)
                                              Container(
                                                height: size.width * 0.003,
                                                margin: EdgeInsets.only(
                                                  right: 0,
                                                  left: size.width * 0.11,
                                                ),
                                                color: Colors.grey[300],
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          )),
                    ),
                    // Logo container at top
                    const LogoCustom(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class LogoCustom extends StatelessWidget {
  const LogoCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    final decoration2 = BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: kPrimaryColor,
        width: 2.5,
      ),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 15,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: -2,
          offset: const Offset(0, 6),
        ),
      ],
    );

    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onDoubleTap: () {
          authBloc.add(const OnChangeStatusViewInfo(viewInfoSearch: false));
        },
        child: Container(
          width: size.width * 0.2,
          height: size.width * 0.2,
          decoration: decoration2,
          padding: EdgeInsets.all(size.width * 0.01),
          child: Image.asset(
            "assets/SantaCruz-logo2.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class IconCustomSearch extends StatelessWidget {
  const IconCustomSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.04,
        left: size.width * 0.01, // Añadido padding izquierdo
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            authBloc.add(const OnChangeStatusViewInfo(viewInfoSearch: true));
          },
          child: Container(
            width: size.width * 0.14, // Aumentado tamaño
            height: size.width * 0.14, // Mantener proporción cuadrada
            decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.25),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]),
            child: Container(
              margin: EdgeInsets.all(size.width * 0.02), // Margen uniforme
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.searchengin,
                color: kPrimaryColor,
                size: size.width * 0.075, // Ajustado tamaño del icono
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DangerZoneDetailView extends StatelessWidget {
  const DangerZoneDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final List<Map<String, dynamic>> dangerLevels = [
      {
        "nivel": "Crítico",
        "color": const Color(0xFFDC2626),
        "descripcion": "Zona de alto riesgo. Precaución extrema requerida.",
        "icono": FontAwesomeIcons.circleExclamation
      },
      {
        "nivel": "Alto",
        "color": const Color(0xFFF97316),
        "descripcion": "Área con riesgos significativos. Mayor atención.",
        "icono": FontAwesomeIcons.triangleExclamation
      },
      {
        "nivel": "Medio",
        "color": const Color(0xFFFACC15),
        "descripcion": "Zona con riesgos moderados. Mantener precaución.",
        "icono": FontAwesomeIcons.exclamation
      },
      {
        "nivel": "Bajo",
        "color": const Color(0xFF22C55E),
        "descripcion": "Área generalmente segura. Precauciones básicas.",
        "icono": FontAwesomeIcons.shield
      },
      {
        "nivel": "Mínimo",
        "color": const Color(0xFF3B82F6),
        "descripcion": "Zona monitoreada y segura.",
        "icono": FontAwesomeIcons.check
      },
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.04,
        right: size.width * 0.02,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: size.width * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.03),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(size.width * 0.03),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * 0.03),
                      topRight: Radius.circular(size.width * 0.03),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Niveles de Riesgo",
                        style: letterStyle.letra1Mapa.copyWith(
                          color: kPrimaryColor,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          authBloc.add(const OnChangeStatusViewInfoDetails());
                        },
                        icon: Icon(
                          FontAwesomeIcons.xmark,
                          size: size.width * 0.05,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dangerLevels.length,
                  itemBuilder: (context, index) {
                    final level = dangerLevels[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.width * 0.03,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: index != dangerLevels.length - 1 ? 1 : 0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(size.width * 0.02),
                            decoration: BoxDecoration(
                              color: level['color'].withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.02),
                            ),
                            child: Icon(
                              level['icono'],
                              color: level['color'],
                              size: size.width * 0.05,
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level['nivel'],
                                  style: letterStyle.letra1Mapa.copyWith(
                                    color: level['color'],
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                                SizedBox(height: size.width * 0.01),
                                Text(
                                  level['descripcion'],
                                  style: letterStyle.letra3Mapa.copyWith(
                                    color: kTerciaryColor,
                                    fontSize: size.width * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconMenuCustomDetail extends StatelessWidget {
  const IconMenuCustomDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.04,
        left: size.width * 0.01, // Añadido padding izquierdo
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            // authBloc.add(const OnChangeStatusViewInfo(viewInfoSearch: true));
            authBloc.add(const OnChangeStatusViewInfoDetails());
          },
          child: Container(
            width: size.width * 0.14, // Aumentado tamaño
            height: size.width * 0.14, // Mantener proporción cuadrada
            decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.25),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]),
            child: Container(
              margin: EdgeInsets.all(size.width * 0.02), // Margen uniforme
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.circleInfo,
                color: kPrimaryColor,
                size: size.width * 0.075, // Ajustado tamaño del icono
              ),
            ),
          ),
        ),
      ),
    );
  }
}
