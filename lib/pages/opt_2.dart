/*
  Pagina con la informacion principal de la app.
*/

import 'package:flutter/material.dart';

import 'package:sidebar_animada/blocs/navigation_bloc.dart';

class Opt2 extends StatelessWidget with NavigationStates {

  // Parte Visible.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("opcion 2"),
    );
  }
}