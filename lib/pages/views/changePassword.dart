import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({this.user});
  final User user;
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _textPasswordController = new TextEditingController();
  TextEditingController _textNewPasswordController =
      new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            backgroundColor: const Color(0xFFCE0000),
            title: new Text('Mudar senha',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))),
        backgroundColor: Colors.white,
        body: Form(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                    top: 100.0, left: 24.0, right: 24.0, bottom: 50.0),
                children: <Widget>[
              SizedBox(height: 50.0),
              TextField(
                controller: _textPasswordController,
                decoration: InputDecoration(
                    labelText: 'Senha Atual',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _textNewPasswordController,
                decoration: InputDecoration(
                    labelText: 'Senha Escolhida',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              GradientButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangePasswordPage(user: widget.user)));
                },
                gradient: Gradients.buildGradient(
                    Alignment.topLeft,
                    Alignment.bottomRight,
                    [const Color(0xFFCE0000), const Color(0xFFB71C1C)]),
                increaseWidthBy: 60.0,
                increaseHeightBy: 10.0,
                child: Center(
                  child: Text('Atualizar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Noto')),
                ),
              )
            ])));
  }

  Future<void> updatePassword() async {
    var _password = _textPasswordController.text,
        _newPassword = _textNewPasswordController.text;

    ResponseHandling().validatePassword(_newPassword);
    try {
      var jsonData =
          '{ "oldPassword" : "$_password", "newPassword" : "$_newPassword"}';
      await UserController().changePassword(jsonData, widget.user.token);
      Fluttertoast.showToast(
          msg: "Senha alterada com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
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
}
