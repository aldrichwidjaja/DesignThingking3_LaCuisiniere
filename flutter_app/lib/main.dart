import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/state_widget.dart';

// - StateWidget incl. state data
//    - RecipesApp
//        - All other widgets which are able to access the data
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new StateWidget(
    child: new RecipesApp(),
));
}