import 'package:app_sw1final/features/auth/presentation/screens/auth.screen.dart';
import 'package:app_sw1final/features/auth/presentation/screens/informe-securidad.screen.dart';
import 'package:app_sw1final/features/map/presentation/screens/map-google.screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/map', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const AuthScreen(),
  ),
  GoRoute(
    path: '/map',
    builder: (context, state) => const MapGoogleScreen(),
  ),
  GoRoute(
    path: '/generarReporte',
    builder: (context, state) => const GenerarDenunciaScreen(),
  ),
]);
