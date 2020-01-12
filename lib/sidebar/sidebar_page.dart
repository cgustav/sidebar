/*
  Entablece una relacion entre el Homepage y el sidebar_page para que el usuario pueda ver e interactuar
  con el sidebar sin dejar de ver el Homepage.
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebar_animada/blocs/navigation_bloc.dart';

import 'package:sidebar_animada/sidebar/sidebar.dart';

// Clase Sidebar
class Sidebar extends StatelessWidget {

  // Parte visible de la pagina "Sidebar".
  @override
  Widget build(BuildContext context) {

    // Muestra la patantalla principal "HOMEPAGE" + "Sidebar_page".
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState){
                return navigationState as Widget;
              }, 
            ),
            SideBar(),
          ],
        ),
      ),  
    );
  }
}