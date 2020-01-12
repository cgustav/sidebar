import 'package:flutter/material.dart';

import 'package:sidebar_animada/sidebar/sidebar_page.dart';

// Iniciar "MyApp"
void main() => runApp(MyApp());

// "MyApp" - inicia la aplicacion.
class MyApp extends StatelessWidget {

    Widget build(BuildContext context) {
      
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        // Color de fondo de todos los Scaffold.
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white
        ),
        // Ruta que inicia MyApp.
        home: Sidebar(),
    );
  }
}