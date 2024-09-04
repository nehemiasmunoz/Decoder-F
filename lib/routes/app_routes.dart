import 'package:flutter/material.dart';

import '../views/screens/views.dart';

class AppRoutes {
  static const initialRoute = "splash";
  static final Map<String, Widget Function(BuildContext)> routes = {
    "splash": (BuildContext _) => const SplashView(),
    "home": (BuildContext context) => const HomeView(),
    "register": (ctx) => const UserRegisterView(),
  };
}
