import 'package:decoder/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'controllers/provider/providers.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<IngredientSearchProvider>(
          create: (_) => IngredientSearchProvider(),
        ),
        ChangeNotifierProvider<GeminiProvider>(
          create: (_) => GeminiProvider(),
        ),
        ChangeNotifierProvider<IngredientDatabaseProvider>(
          create: (_) => IngredientDatabaseProvider()..init(),
        ),
        ChangeNotifierProvider<UserForm>(
          create: (_) => UserForm(),
        ),
        ChangeNotifierProvider<UserDatabaseProvider>(
          create: (_) => UserDatabaseProvider()..init(),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
