import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/views/authentication/sign_in_screen.dart';
import 'package:incident_tracker_app/views/incident/create_incident_screen.dart';
import 'package:incident_tracker_app/views/pages_container_screen.dart';
import 'package:incident_tracker_app/views/splash/splash_screen.dart';

final itaRouters = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return SignInScreen();
      },
    ),
    GoRoute(
      path: '/homepage',
      name: 'Homepage',
      builder: (context, state) {
        return PagesContainerScreen();
      },
    ),
    GoRoute(
      path: '/createIncident',
      name: 'CreateIncident',
      builder: (context, state) {
        return CreateIncidentScreen();
      },
    ),
  ],
);
