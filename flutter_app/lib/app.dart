import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';

import 'RecipeBook.dart';

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      routes: {
        '/': (context) => recipebookstate(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}