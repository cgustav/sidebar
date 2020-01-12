/*
  Permite que al hacer click en los iconos de la barra de navegacion solo se modifique la parte contendia
  por el home_page, sin interrumpir la barra de navegacion.
*/

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sidebar_animada/pages/home_page.dart';
import 'package:sidebar_animada/pages/opt_1.dart';
import 'package:sidebar_animada/pages/opt_2.dart';

// Enumerar la acciones disponibles.
enum NavigationEvents {
  HomePageClickEvent, 
  MyAccountClikedEvent, 
  MyOrdersClickedEvent
}

abstract class NavigationStates {}

// Crear las rutas de las paginas
class NavigationBloc extends Bloc<NavigationEvents, NavigationStates>{
  
  // Indica que la ruta inicial en la que aparece sea la del HomePage.
  @override  
  get initialState => HomePage();

  // Crea un mapa de todas las rutas para poder navegar entre ellas desde los botones de la barra de navegacion
  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {

    switch(event){
      case NavigationEvents.HomePageClickEvent:
      yield HomePage();
      break;
      case NavigationEvents.MyAccountClikedEvent:
        yield Opt1();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield Opt2();
        break;
    }
    

    
    
  }

}

