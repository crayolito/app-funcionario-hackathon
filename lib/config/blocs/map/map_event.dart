part of 'map_bloc.dart';

class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitContent extends MapEvent {
  const OnMapInitContent();
}

class OnGoogleMapController extends MapEvent {
  final GoogleMapController controller;
  const OnGoogleMapController(this.controller);
}

class OnCameraPosition extends MapEvent {
  final CameraPosition cameraPosition;
  const OnCameraPosition(this.cameraPosition);
}

class OnChangeDetailMapGoogle extends MapEvent {
  final DetailMapGoogle detail;

  const OnChangeDetailMapGoogle(this.detail);
}

class OnChangeDetailSantaCruz extends MapEvent {
  final DetailSanCruz detail;

  const OnChangeDetailSantaCruz(this.detail);
}

class OnChangeReportMainCategory extends MapEvent {
  final ReportMainCategory category;

  const OnChangeReportMainCategory(this.category);
}
