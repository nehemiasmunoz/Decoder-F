import 'package:decoder/src/domain/models/ingredient/ingredient_model.dart';
import 'package:decoder/src/presentation/ui/screens/screens.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final routes = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) {
          final Ingredient ingredient = state.extra! as Ingredient;
          return DetailScreen(
            ingredient: ingredient,
          );
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const UserRegisterScreen(),
      )
    ],
  );
}
