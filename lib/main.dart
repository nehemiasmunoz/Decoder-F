import 'package:decoder/routes/app_routes.dart';
import 'package:decoder/src/data/provider/ingredient/ingredient_search_provider.dart';
import 'package:decoder/src/data/provider/providers.dart';
import 'package:decoder/src/data/provider/user/form/user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

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
            create: (_) => IngredientSearchProvider()),
        ChangeNotifierProvider<GeminiProvider>(create: (_) => GeminiProvider()),
        ChangeNotifierProvider<IngredientDatabaseProvider>(
            create: (_) => IngredientDatabaseProvider()),
        ChangeNotifierProvider<UserForm>(create: (_) => UserForm()),
        ChangeNotifierProvider<UserDatabaseProvider>(
            create: (_) => UserDatabaseProvider()),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
