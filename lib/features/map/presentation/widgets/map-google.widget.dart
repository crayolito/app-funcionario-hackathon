import 'package:app_sw1final/config/blocs/map/map_bloc.dart';
import 'package:app_sw1final/config/constant/styleMap.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewGoogleMap extends StatefulWidget {
  const MapViewGoogleMap(
      {super.key,
      required this.initialLocation,
      required this.polygons,
      required this.polylines,
      required this.markers});

  final LatLng initialLocation;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  @override
  State<MapViewGoogleMap> createState() => _MapViewGoogleMapState();
}

class _MapViewGoogleMapState extends State<MapViewGoogleMap> {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final CameraPosition initialCameraPosition =
        CameraPosition(target: widget.initialLocation, zoom: 17);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        // trafficEnabled: true,
        buildingsEnabled: true,
        indoorViewEnabled: true,
        zoomGesturesEnabled: true,
        //
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        compassEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        onMapCreated: (GoogleMapController controller) {},
        onCameraMove: (CameraPosition position) {
          mapBloc.add(OnCameraPosition(position));
        },
        markers: widget.markers,
        polylines: widget.polylines,
        polygons: widget.polygons,
        style: mapStyleCustom,
        mapType: getMapTypeFromDetail(mapBloc.state.detailMapGoogle),
      ),
    );
  }

  MapType getMapTypeFromDetail(DetailMapGoogle detailMap) {
    switch (detailMap) {
      case DetailMapGoogle.normal:
        return MapType.normal;
      case DetailMapGoogle.satellite:
        return MapType.satellite;
      case DetailMapGoogle.hybrid:
        return MapType.hybrid;
      case DetailMapGoogle.terrain:
        return MapType.terrain;
      case DetailMapGoogle.none:
        return MapType.normal;
    }
  }
}
