import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = new GlobalKey();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool visible = true;
  String mobile, password;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: new Container(
          width: MediaQuery.of(context).size.width, child: _linkSignUp()),
      body: new Form(key: _key, autovalidate: _validate, child: _body(context)),
    );
  }

  _body(BuildContext context) =>
      ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        Container(
            padding: EdgeInsets.all(15),
            child: Column(children: <Widget>[_formUI(), _socialSignIn()]))
      ]);
  @override
  void dispose() {
    if (this.mounted) super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _formUI() {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40.0),
          _inputEmail(),
          SizedBox(height: 12.0),
          _inputPassword(),
          SizedBox(height: 20.0),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                splashColor: Colors.orange,
                elevation: 0,
                highlightElevation: 0,
                padding: const EdgeInsets.all(15.0),
                child: Text("Submit".toUpperCase()),
                onPressed: () {
                  _sendToServer();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              )),
          _linkForgotPassword()
        ],
      ),
    );
  }

  _inputEmail() {
    return new TextFormField(
      controller: _emailController,
      decoration: new InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Email',
        prefixIcon: _prefixIcon(Icons.email),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (str) {
        mobile = str;
      },
    );
  }

  _inputPassword() {
    return TextFormField(
        controller: _passwordController,
        obscureText: visible,
        validator: validatePassword,
        readOnly: true,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            hintText: 'Password',
            prefixIcon: _prefixIcon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            suffix: InkWell(
              child: visible
                  ? Icon(
                      Icons.visibility_off,
                      size: 18,
                      color: Colors.orange,
                    )
                  : Icon(
                      Icons.visibility,
                      size: 18,
                      color: Colors.orange,
                    ),
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
            )),
        onSaved: (str) {
          password = str;
        });
  }

  _prefixIcon(IconData iconData) {
    return Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.grey,
        ));
  }

  _linkForgotPassword() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
                child: new Text('Forgot password?',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () {})
          ])
    ]);
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  _linkSignUp() => Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You do not have account?',
                style: TextStyle(color: Colors.grey)),
            new FlatButton(
              child: new Text('Sign up',
                  style: TextStyle(
                      color: Colors.black87,
                      //decoration: TextDecoration.underline,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {},
            ),
          ],
        ),
      );
  _socialSignIn() {
    return Container(
        child: Column(children: <Widget>[
      SizedBox(height: 40.0),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.black12,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          width: 100.0,
          height: 1.0,
        ),
        Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            )),
        Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Colors.black12,
                  Colors.grey,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          width: 100.0,
          height: 1.0,
        )
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0.0),
            child: new RaisedButton(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                highlightElevation: 0.0,
                onPressed: () {},
                splashColor: Colors.grey.withOpacity(0.2),
                highlightColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                ),
                child: Icon(
                  FontAwesomeIcons.facebookF,
                  size: 20,
                  color: Colors.blueAccent,
                )),
          ),
          Container(
            margin: EdgeInsets.all(0.0),
            child: new RaisedButton(
                color: Colors.white,
                padding: const EdgeInsets.all(12.0),
                highlightElevation: 0.0,
                onPressed: () {},
                splashColor: Colors.grey.withOpacity(0.2),
                highlightColor: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                ),
                child: Icon(
                  FontAwesomeIcons.google,
                  size: 20,
                  color: Colors.red,
                )),
          ),
        ],
      )
    ]));
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}
