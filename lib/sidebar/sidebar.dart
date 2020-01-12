/*
  Crear el sidebar + funciones del sidebar
*/

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:sidebar_animada/blocs/navigation_bloc.dart';
import 'package:sidebar_animada/sidebar/menu_item.dart';

// Barra de navegacion.
class SideBar extends StatefulWidget {

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar>{
  
  // Variable para identificar la accion de cerrar o abrir la barra de navegacion.
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController ;
  Stream<bool> isSidebarOpenedStream;
  StreamSink isSidebarOpenedSink;

  // Tiempo que dura la animacion de abrir y cerrar la barra de navegacion.  
  final _animationDuration = const Duration(milliseconds: 500);

  // Fucion para abrir y cerrar la barra de navegacion 
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  // Accion del icono sobresaliente en la barra de navegacion. (abrir o cerrar la barra de navegacion).
  void onIconPressed(){
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    debugPrint("Icono de la barra de navegacion presionado.");

    if (isAnimationCompleted){
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
      debugPrint("barra de navegacion cerrada");
    }else{
      isSidebarOpenedSink.add(true);
      _animationController.forward();
      debugPrint("barra de navegacion abierta");
    }
  }

  // Parte Visible.
  @override
  Widget build(BuildContext context) {

    // Alcance de la barra de navegacion sobre la pantalla.
    final screenWidth = MediaQuery.of(context).size.width;

    // Verifica si la barra esta abierta o cerrada.
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync){
        // Expande la barra de navegacion a los parametros determinados en las variables.
        // Agrega animacion al abrir o cerrar la barra de navegacion.
        // Evita que al cerrar la barra de navegacion se distorcione el contenido de la misma.
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          // Columna que dividide el contenedor principal del espacio el blanco en la parte derecha de la pantalla
          child: Row(
            children: <Widget>[
              // Contenedor principal.
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFF262AAA),
                  // Diseño dentro de la barra de navegacion.
                  child: Column(
                    children: <Widget>[
                      // Parte superior de la barra de navegacion.
                      SizedBox(height: 100),
                      ListTile(
                        // Nombre del usuario. 
                        title: Text("Nombre", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800,),
                      ),
                        // Email del usuario.
                        subtitle: Text("Email@email.com", style: TextStyle(color: Colors.white54 , fontSize: 18, fontWeight: FontWeight.w800)
                        ),
                        // Foto de perfil del usuario.
                        leading: CircleAvatar(
                          child: Icon(Icons.perm_identity, color: Colors.white),
                          radius: 40,
                        )
                      ),
                      // Barra que separa la parte superior de la parte del medio de la barra de navegacion.
                      Divider(
                        height: 64,
                        thickness: 0.5, 
                        color: Colors.white, 
                        indent: 32, 
                        endIndent: 32
                      ),
                      // Parte Media de la barra de navegacion.
                      // Opcion 1.
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickEvent);
                        },
                      ),
                      // Opcion 2.
                      MenuItem(
                        icon: Icons.person,
                        title: "Opcion 1",
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAccountClikedEvent);
                        },
                      ),
                      // Opcion 3.
                      MenuItem(
                        icon: Icons.shopping_basket,
                        title: "Opcion 2",
                        onTap: (){
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyOrdersClickedEvent);
                        },
                      ),
                      // Opcion 4.
                      MenuItem(
                        icon: Icons.card_giftcard,
                          title: "Opcion 3",
                      ),
                      // Barra que separa la parte media de la parte inferior de la barra de navegacion.
                       Divider(
                        height: 64,
                        thickness: 0.5, 
                        color: Colors.white, 
                        indent: 16, 
                        endIndent: 16
                      ),
                      // Parte inferior de la barra de navegacion.
                      // Opcion 5.
                      MenuItem(
                        icon: Icons.settings,
                        title: "Opcion 4",
                      ),
                      // Opcion 6.
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Opcion 5",
                      ),
                    ]
                  ),
                ),
              ),
              // Parte que sobresale del contendor principal de la barra de navegacion.
              // Contiene el boton para abrir y cerra la barra de navegacion.
              Align(
                alignment: Alignment(0, -0.9),
                // Accion al hacer tap sobre la parte sobresaliente de la barra de navegacion.
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  // Diseño del borde sobresaliente + icono.  
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      // Icono en el cuadrado sobresaliente de la barra de navegacion.
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }  
}

// Diseño personalizado del borde sobresaliente de la barra de navegacion.
class CustomMenuClipper extends CustomClipper<Path>{

  // Crear los bordes + el rrelleno del cuadro personalizado.
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    // Idenrificar la altura y anchura del cuadrado.
    final width = size.width;
    final height = size.height;

    // Direccion de los bordes dentro del cuadrado.
    Path path = Path();
    path.moveTo(0,0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    // Devuelve el personalizado.
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
