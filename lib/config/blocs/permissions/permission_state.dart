part of 'permission_bloc.dart';

// ignore: must_be_immutable
class PermissionState extends Equatable {
  // LOGIC : GPS ESTADO
  final bool isGpsEnabled;
  // LOGIC : PERMISOS DEL GPS
  final bool isGpsPermissionGranted;
  // LOGIC : Empezar a seguir al usuario
  final bool isFollowingUser;
  // LOGIC : Ultima ubicacion conocida
  LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;

  PermissionState({
    this.isGpsEnabled = false,
    this.isGpsPermissionGranted = false,
    this.isFollowingUser = false,
    this.lastKnownLocation,
    this.myLocationHistory = const [],
  });

  PermissionState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
    bool? isNotifiPermission,
    bool? isFollowingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) {
    return PermissionState(
      isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
      isGpsPermissionGranted:
          isGpsPermissionGranted ?? this.isGpsPermissionGranted,
      isFollowingUser: isFollowingUser ?? this.isFollowingUser,
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      myLocationHistory: myLocationHistory ?? this.myLocationHistory,
    );
  }

  @override
  List<Object?> get props => [
        isGpsEnabled,
        isGpsPermissionGranted,
        isFollowingUser,
        lastKnownLocation,
        myLocationHistory,
      ];
}
