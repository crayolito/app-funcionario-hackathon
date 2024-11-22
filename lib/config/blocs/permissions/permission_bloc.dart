import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  StreamSubscription? gpsServiceSubscription;
  StreamSubscription<Position>? _positionStream;

  PermissionBloc() : super(PermissionState()) {
    // READ : EVENTOS BLOC SOBRE EL GPS
    on<GpsAndPermissionEvent>((event, emit) {
      emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isPermissionGranted,
      ));
    });

    on<OnNewLocationUserEvent>((event, emit) {
      emit(state.copyWith(
        lastKnownLocation: event.newLocation,
      ));
    });
    on<OnStartFollowingUserEvent>((event, emit) {
      emit(state.copyWith(
        isFollowingUser: true,
      ));
    });
    on<OnStopFollowingUserEvent>((event, emit) {
      emit(state.copyWith(
        isFollowingUser: false,
      ));
    });

    // LOGIC : VERIFICAR GPS ESTADO Y PERMISO USO DE GPS
    _init();
  }

  // READ : METODOS DE USO A TODO LO REFENTE AL GPS
  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([
      _chechGpsStatus(),
      _isPermissionGranted(),
    ]);

    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isPermissionGranted: gpsInitStatus[1],
    ));
  }

  Future<bool> _chechGpsStatus() async {
    final isGpsEnabled = await Permission.location.serviceStatus.isEnabled;
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isGpsEnabled = (event.index == 1) ? true : false;
      add(GpsAndPermissionEvent(
        isGpsEnabled: isGpsEnabled,
        isPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    return isGpsEnabled;
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isPermissionGranted: true,
        ));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(
          isGpsEnabled: state.isGpsEnabled,
          isPermissionGranted: false,
        ));
        openAppSettings();
        break;
    }
  }

  // READ : METODOS PARA EL USO DE LA GEOLOCALIZACION
  Future<Position> getActualPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewLocationUserEvent(LatLng(
      position.latitude,
      position.longitude,
    )));
    return position;
  }

  void startFollowingUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    // LOGIC : Verificar si los servicios de ubicacion estan habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // LOGIC : Los servicios de ubicacion no estan habilitados
      return Future.error('Los servicios de ubicacion no estan habilitados');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // LOGIC : El usuario no dio permisos de ubicacion
        return Future.error('El usuario no dio permisos de ubicacion');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // LOGIC : El usuario no dio permisos de ubicacion
      return Future.error('El usuario no dio permisos de ubicacion');
    }

    // LOGIC : Si llegamos a este punto, el usuario dio permisos de ubicacion
    add(const OnStartFollowingUserEvent());

    _positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewLocationUserEvent(LatLng(
        position.latitude,
        position.longitude,
      )));
    }, onError: (error) {
      add(const OnStopFollowingUserEvent());
    });
  }

  Future<void> stopFollowingUser() async {
    await _positionStream?.cancel();
    add(const OnStopFollowingUserEvent());
  }

  @override
  Future<void> close() {
    gpsServiceSubscription!.cancel();
    stopFollowingUser();
    return super.close();
  }
}
