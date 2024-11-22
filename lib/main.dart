import 'package:app_sw1final/config/blocs/auth/auth_bloc.dart';
import 'package:app_sw1final/config/blocs/map/map_bloc.dart';
import 'package:app_sw1final/config/blocs/permissions/permission_bloc.dart';
import 'package:app_sw1final/config/constant/initContext.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_sw1final/config/router/app.router.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => PermissionBloc()),
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => MapBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      InitContext.inicializar(context);

      return MaterialApp.router(
          debugShowCheckedModeBanner: false, routerConfig: appRouter);
    });
  }
}
