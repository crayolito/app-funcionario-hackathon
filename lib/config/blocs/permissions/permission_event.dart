part of 'permission_bloc.dart';

sealed class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissionEvent extends PermissionEvent {
  final bool isGpsEnabled;
  final bool isPermissionGranted;

  const GpsAndPermissionEvent(
      {required this.isGpsEnabled, required this.isPermissionGranted});
}

class OnNewLocationUserEvent extends PermissionEvent {
  final LatLng newLocation;

  const OnNewLocationUserEvent(this.newLocation);
}

class OnStartFollowingUserEvent extends PermissionEvent {
  const OnStartFollowingUserEvent();
}

class OnStopFollowingUserEvent extends PermissionEvent {
  const OnStopFollowingUserEvent();
}
