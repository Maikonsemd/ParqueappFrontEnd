import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
          title: Text("Bem-Vindo"),
       ),
       body: _body(),
     );
  }

  _body() {
    return Center(
      child: Text( 
        "Macorattti",
        style: TextStyle(
          fontSize: 20,
      ),
    ),
   );
  }

}


