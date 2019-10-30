import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './home.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset('assets/images/glaceon.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onSaved: (input) => _email = input,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: InputBorder.none,
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onSaved: (input) => _password = input,
      decoration: InputDecoration(
        hintText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: InputBorder.none,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: () {
          signIn();
        },
        padding: EdgeInsets.all(20),
        color: Colors.redAccent,
        child: Text('Login', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Esqueceu a senha?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final registerLabel = FlatButton(
        child: Text(
          'Não tem uma conta? Cadastre-se',
          style: TextStyle(color: Colors.black54),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupPage()));
        });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: 100.0, left: 24.0, right: 24.0, bottom: 50.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            forgotLabel,
            loginButton,
            registerLabel
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (DotEnv().env['FATAPP_REQUEST'].compareTo('TRUE') == 0) {
      final formState = _formKey.currentState;
      if (formState.validate()) {
        formState.save();
        ResponseHandling().validateEmail(_email);
        ResponseHandling().validatePassword(_password);

        var jsonData = '{ "email" : "$_email", "password" : "$_password" }';
        try {
          final tokenResponse = await UserController().login(jsonData);
          User token = User.token(tokenResponse);
          final userResponse =
              await UserController().show(token.id, token.token);
          User user = User.fromJson(userResponse, token.token);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage(user: user)));
        } catch (e) {
          Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
