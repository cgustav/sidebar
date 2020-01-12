/*
  Diseño que va a aparecer en cada opcion dentro de la barra de navegacion mostrando un 
  icono y el titulo de esa opcion. 
*/

import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {

  // Variables para identificar los datos.
  final IconData icon;
  final String title;
  final Function onTap;

  // Contructor para identificar el icono y el texto dentro de cada campo de opciones
  // puesta dentro de cada opcion en la barra de navegacion.
  const MenuItem({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  // Parte visible.
  @override
  Widget build(BuildContext context) {

    // Distancia dentro de la barra de navegacion donde se va a mostrar el icono + el titulo.
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        // Columna del icono + el titulo.
        child: Row(
          children: <Widget>[
            // Icono.
            Icon(
              icon,
              color: Colors.cyan,
              size: 30,
            ),
            // Separacion entre el icono y el titulo.
            SizedBox(width: 20),
            // Titulo.
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 26,
                color: Colors.white
              ),         
            )
          ],
        ),
      ),
    );
  }
}