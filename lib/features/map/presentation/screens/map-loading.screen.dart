import 'package:app_sw1final/config/blocs/map/map_bloc.dart';
import 'package:app_sw1final/config/blocs/permissions/permission_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapLoading extends StatefulWidget {
  const MapLoading({
    super.key,
  });

  @override
  State<MapLoading> createState() => _MapLoadingState();
}

class _MapLoadingState extends State<MapLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final permissionBloc = BlocProvider.of<PermissionBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    await permissionBloc.askGpsAccess();
    await permissionBloc.getActualPosition();
    mapBloc.add(const OnMapInitContent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                width: size.width * 0.6,
                height: size.height * 0.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/esperando.gif"),
                        fit: BoxFit.fill)))));
  }
}
