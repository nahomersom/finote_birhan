import 'package:flutter/material.dart';
import 'package:hisnate_kifele/Data/Data%20Providers/light_theme.dart';

import 'Presentation/Screens/Home/UI/Dashboard.dart';
import 'Presentation/Screens/Home/UI/WorkSpace.dart';
import 'Presentation/Screens/Registration/UI/registeration.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home:  WorkSpace(),
    );
  }
}

