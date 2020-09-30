import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Senha",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final buttonLoginScreen = ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: RaisedButton(
            color: Colors.blue,
            child: Text("Entrar",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ); //mudança de tela
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))));
    Text(
      'esqueci minha senha',
      style: TextStyle(
        fontSize: 40,
        color: Colors.pink,
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(40.0),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 150.0,
                    child: Image.asset("images/login.png", fit: BoxFit.contain),
                  ),
                  SizedBox(height: 40.0),
                  emailField,
                  SizedBox(height: 20.0),
                  passwordField,
                  SizedBox(height: 30.0),
                  buttonLoginScreen,
                ])),
          ),
        ));
  }
}
