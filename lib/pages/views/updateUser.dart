import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/changePassword.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masked_text/masked_text.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({this.user});
  final User user;
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController _textRAController = new TextEditingController();
  TextEditingController _textEmailController = new TextEditingController();
  TextEditingController _textNameController = new TextEditingController();
  TextEditingController _textCPFController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.getValues();
    
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                  child: Text(
                    'Perfil',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Column(children: <Widget>[
                TextField(
                  controller: _textNameController,
                  decoration: InputDecoration(
                      labelText: 'Nome Completo',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _textEmailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 10.0),
                MaskedTextField(
                  maskedTextFieldController: _textCPFController,
                  mask: "xxx.xxx.xxx-xx",
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  inputDecoration: new InputDecoration(
                      enabled: false,
                      labelText: 'CPF',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                MaskedTextField(
                    maskedTextFieldController: _textRAController,
                    maxLength: 13,
                    keyboardType: TextInputType.number,
                    inputDecoration: new InputDecoration(
                      enabled: false,
                      labelText: 'RA',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    )),
                SizedBox(height: 20.0),
                Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.redAccent,
                      child: Center(
                        child: Text(
                          'Atualizar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    )),
                SizedBox(height: 20.0),
                Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.redAccent,
                      elevation: 7.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangePasswordPage(user: widget.user)));
                        },
                        color: Colors.redAccent,
                        child: Center(
                          child: Text(
                            'Mudar Senha',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                //       child: InkWell(
                // ],
                // )),
              ]))
        ]));
  }

  getValues() {
    _textNameController.text = widget.user.name;
    _textCPFController.text = widget.user.cpf;
    _textEmailController.text = widget.user.email;
    if (widget.user.student != null) {
      _textRAController.text = widget.user.student.ra;
    }
  }

  Future<void> update() async {
    var _name = _textNameController.text, _email = _textEmailController.text;

    ResponseHandling().validateEmail(_email);
    try {
      var jsonData = '{ "name" : "$_name", "email" : "$_email" }';
      final update = await UserController()
          .update(widget.user.id, jsonData, widget.user.token);
      User user = User.fromJson(update, widget.user.token);
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
}
