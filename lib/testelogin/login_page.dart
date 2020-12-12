import 'package:flutter/material.dart';
import 'package:testelogin/alert.dart';
import 'package:testelogin/home_page.dart';
import 'package:testelogin/http_api.dart';

import 'api_response.dart';

class LoginPage extends StatelessWidget {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fazer o Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _body(context),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            textFormFieldLogin(),
            textFormFieldSenha(),
            containerButton(context)
          ],
        ));
  }

  TextFormField textFormFieldLogin() {
    return TextFormField(
        controller: _tLogin,
        validator: _validateLogin,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Login",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Informe a senha"));
  }

  TextFormField textFormFieldSenha() {
    return TextFormField(
        controller: _tSenha,
        validator: _validateSenha,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Informe a senha"));
  }

  Container containerButton(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text("Login",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        onPressed: () {
          _onClickLogin(context);
        },
      ),
    );
  }

  _onClickLogin(BuildContext context) async {
    final login = _tLogin.text;
    final senha = _tSenha.text;

    print("Login: $login , Senha: $senha ");

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      //Usuario usuario = response.result;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      alert(context, "Erro no Login");
    }
  }
}
