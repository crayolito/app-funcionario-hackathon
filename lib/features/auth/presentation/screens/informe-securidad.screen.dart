import 'package:app_sw1final/config/blocs/auth/auth_bloc.dart';
import 'package:app_sw1final/config/blocs/map/map_bloc.dart';
import 'package:app_sw1final/config/constant/colors.const.dart';
import 'package:app_sw1final/config/constant/data.const.dart';
import 'package:app_sw1final/config/constant/sizes.const.dart';
import 'package:app_sw1final/config/services/camera.gallery.service.impl.dart';
import 'package:flutter/material.dart';

class GenerarDenunciaScreen extends StatefulWidget {
  const GenerarDenunciaScreen({super.key});

  @override
  State<GenerarDenunciaScreen> createState() => _GenerarDenunciaScreenState();
}

class _GenerarDenunciaScreenState extends State<GenerarDenunciaScreen> {
  String _imagePath =
      "https://www.idl.org.pe/wp-content/uploads/2023/06/000960559W.jpg";
  ReportMainCategory? _mainCategory;
  ReportSubcategory? _subCategory;
  String? _typeDenuncia;
  final List<String> _denuncias = [
    "Atraco",
    "Vehículo",
    "Vivienda o Local",
    "Secuestro",
    "Que tipo de denuncia?"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _typeDenuncia = _denuncias[4];
    _mainCategory = ReportMainCategory.delitos;
    _subCategory = ReportSubcategory.robo;
  }

  @override
  Widget build(BuildContext context) {
    final cameraGalleryServiceImpl = CameraGalleryServiceImpl();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_imagePath), fit: BoxFit.cover)),
              ),
              // READ : OPCIONES DE NAVEGACIÓN EN LA VENTANA
              const ContainerOptionsCustom(),
              // READ : FORMULARIO DE REPORTE DE SEGURIDAD CIUDADANA
              Positioned(
                top: size.height * 0.35,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.015,
                  ),
                  height: size.height * 0.65,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: kPrimaryColor,
                        width: size.width * 0.02,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * 0.08),
                      topRight: Radius.circular(size.width * 0.08),
                    ),
                  ),
                  child: Column(
                    children: [
                      // LOGIC : TITULO DE LA VENTANA
                      Text(
                        "Reporte de Seguridad",
                        style: letterStyle.letra1GD,
                      ),
                      SizedBox(height: size.height * 0.02),
                      // LOGIC : DROPDOWNBUTTON PARA TIPO DE DENUNCIA
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          border: Border.all(
                              color: kPrimaryColor, width: size.width * 0.006),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(0, 5),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.23),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<ReportMainCategory>(
                            value: _mainCategory,
                            hint: Text(
                              'Seleccione categoría principal',
                              style: letterStyle.letra2GD,
                            ),
                            items: mainCategories.entries
                                .map((entry) =>
                                    DropdownMenuItem<ReportMainCategory>(
                                      value: entry.key,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.001),
                                        child: Text(
                                          entry.value,
                                          style: letterStyle.letra2GD,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (ReportMainCategory? value) {
                              setState(() {
                                _mainCategory = value;
                                _subCategory = null;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: kTerciaryColor,
                              size: size.width * 0.08,
                            ),
                            dropdownColor: Colors.white,
                            isExpanded: true,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // LOGIC : DROPDOWNBUTTON PARA SUBCATEGORÍA
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          border: Border.all(
                              color: kPrimaryColor, width: size.width * 0.006),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(0, 5),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.23),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<ReportSubcategory>(
                            value: _subCategory,
                            hint: Text(
                              'Seleccione subcategoría',
                              style: letterStyle.letra2GD,
                            ),
                            items: subCategories[_mainCategory]
                                ?.entries
                                .map((entry) =>
                                    DropdownMenuItem<ReportSubcategory>(
                                      value: entry.key,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.001),
                                        child: Text(
                                          entry.value,
                                          style: letterStyle.letra2GD,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (ReportSubcategory? value) {
                              setState(() {
                                _subCategory = value;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: kTerciaryColor,
                              size: size.width * 0.08,
                            ),
                            dropdownColor: Colors.white,
                            isExpanded: true,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        "Detalles",
                        style: letterStyle.letra1GD,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025,
                            vertical: size.height * 0.01),
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                          border: Border.all(
                              color: kPrimaryColor, width: size.width * 0.006),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.19),
                              offset: const Offset(0, 5),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.23),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          maxLines: 5,
                          style: letterStyle.letra2GD,
                          decoration: InputDecoration(
                            hintText:
                                "Escribe aquí los detalles de la denuncia",
                            hintStyle: letterStyle.letra2GD,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      OptionsReporte(
                        onTap1: () async {
                          String? imagePath =
                              await cameraGalleryServiceImpl.takePhoto();
                          if (imagePath != null) {
                            await _handleImageUpload(imagePath, context,
                                "se está subiendo la imagen");
                          }
                        },
                        onTap2: () async {
                          String? imagePath =
                              await cameraGalleryServiceImpl.selectPhoto();
                          if (imagePath != null) {
                            await _handleImageUpload(imagePath, context,
                                "se está subiendo la imagen");
                          }
                        },
                        onTap3: () {
                          setState(() {
                            _imagePath =
                                "https://www.idl.org.pe/wp-content/uploads/2023/06/000960559W.jpg";
                          });
                        },
                        onTap4: () async {
                          await _showProcessingDialog(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleImageUpload(
      String imagePath, BuildContext context, String message) async {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.03),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size.width * 0.06,
              horizontal: size.width * 0.06,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.width * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.19),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.23),
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Subiendo imagen",
                  style: letterStyle.letra1GD,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.width * 0.04),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  strokeWidth: 3,
                ),
                SizedBox(height: size.width * 0.04),
                Text(
                  "Por favor espere mientras\n$message",
                  textAlign: TextAlign.center,
                  style: letterStyle.letra2GD,
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      String? imageUrl =
          await CameraGalleryServiceImpl.uploadImageToCloudinary(imagePath);
      Navigator.pop(context); // Cerrar diálogo de carga

      if (imageUrl != null) {
        setState(() {
          _imagePath = imageUrl;
        });

        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '¡Imagen subida exitosamente!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context); // Cerrar diálogo de carga
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error al subir la imagen. Intente nuevamente.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showProcessingDialog(BuildContext context) async {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.03),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size.width * 0.06,
              horizontal: size.width * 0.06,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.width * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.19),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Procesando reporte",
                  style: letterStyle.letra1GD,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.width * 0.04),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  strokeWidth: 3,
                ),
                SizedBox(height: size.width * 0.04),
                Text(
                  "Por favor espere mientras\nse procesa su reporte de incidente...",
                  textAlign: TextAlign.center,
                  style: letterStyle.letra2GD,
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      // Esperar 10 segundos
      await Future.delayed(const Duration(seconds: 10));

      // Cerrar diálogo
      Navigator.pop(context);

      // Mostrar SnackBar de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '¡Reporte enviado exitosamente!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 6,
        ),
      );
    } catch (e) {
      // Cerrar diálogo
      Navigator.pop(context);

      // Mostrar SnackBar de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Error al procesar el reporte. Intente nuevamente.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFFE53935),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 6,
        ),
      );
    }
  }
}

class OptionsReporte extends StatelessWidget {
  const OptionsReporte({
    super.key,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
    required this.onTap4,
  });

  final GestureTapCallback onTap1;
  final GestureTapCallback onTap2;
  final GestureTapCallback onTap3;
  final GestureTapCallback onTap4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.08,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onTap1,
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.12,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: Icon(Icons.camera_alt_rounded,
                  color: kSecondaryColor, size: size.width * 0.08),
            ),
          ),
          GestureDetector(
            onTap: onTap2,
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.12,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: Icon(Icons.photo_library,
                  color: kSecondaryColor, size: size.width * 0.08),
            ),
          ),
          GestureDetector(
            onTap: onTap4,
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.12,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: Icon(Icons.save_outlined,
                  color: kSecondaryColor, size: size.width * 0.08),
            ),
          ),
          GestureDetector(
            onTap: onTap3,
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.12,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(size.width * 0.02),
              ),
              child: Icon(Icons.clear,
                  color: kSecondaryColor, size: size.width * 0.08),
            ),
          )
        ],
      ),
    );
  }
}

class ContainerOptionsCustom extends StatelessWidget {
  const ContainerOptionsCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: size.height * 0.038,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.01,
          ),
          height: size.height * 0.06,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.016,
                      vertical: size.height * 0.005),
                  height: size.height * 0.06,
                  width: size.width * 0.13,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTerciaryColor.withOpacity(0.4)),
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.13,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor.withOpacity(0.9)),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: kPrimaryColor,
                      size: size.width * 0.07,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.016,
                      vertical: size.height * 0.005),
                  height: size.height * 0.06,
                  width: size.width * 0.13,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTerciaryColor.withOpacity(0.4)),
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.13,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor.withOpacity(0.9)),
                    child: Icon(
                      Icons.list_rounded,
                      color: kPrimaryColor,
                      size: size.width * 0.07,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
