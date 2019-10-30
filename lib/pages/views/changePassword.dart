import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/updateUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    this.user
  });
  final User user;
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _textPasswordController = new TextEditingController();
  TextEditingController _textNewPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 100.0, left: 24.0, right: 24.0, bottom: 50.0),
            children: <Widget>[
               new Text('Mudar senha',style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
          SizedBox(height: 70.0),
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
          SizedBox(height: 10.0),
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
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                updatePassword();
              },
              padding: EdgeInsets.all(20),
              color: Colors.redAccent,
              child: Text('Mudar senha', style: TextStyle(color: Colors.white)),
            ),
          )
        ]
      )
    ));
  }
  Future<void> updatePassword() async {
    print(widget.user.token);
    var _password = _textPasswordController.text,
        _newPassword = _textNewPasswordController.text;

    ResponseHandling().validatePassword(_newPassword);
    try {
        var jsonData = '{ "oldPassword" : "$_password", "newPassword" : "$_newPassword"}';
        await UserController().changePassword(jsonData, widget.user.token);
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserPage(user : widget.user)));
        Fluttertoast.showToast(
          msg: "Senha alterada com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } catch(e) {      
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }
} 
