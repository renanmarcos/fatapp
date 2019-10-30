import 'package:fatapp/pages/controllers/courseController.dart';
import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/course.dart';
import 'package:fatapp/pages/models/user.dart';
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
  String _course;
  List<Course> courseList;

  bool visibilityRA = false;
  bool visibilityCourse = false;
  bool _isChecked = false;

  TextEditingController _textRAController = new TextEditingController();
  TextEditingController _textEmailController = new TextEditingController();
  TextEditingController _textPasswordController = new TextEditingController();
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
                TextField(
                  controller: _textPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
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
                CheckboxListTile(
                    title: Text("Você é um estudante da FATEC?"),
                    value: _isChecked,
                    onChanged: (val) {
                      setState(() {
                        _isChecked = val;
                        if (val == true) {
                          visibilityRA = true;
                          visibilityCourse = true;
                        } else {
                          visibilityRA = false;
                          visibilityCourse = false;
                        }
                      });
                    }),
                FutureBuilder<List<Course>>(
                    future: CourseController().getCourses(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        courseList = snapshot.data;
                        return Visibility(
                            visible: visibilityCourse,
                            child: DropdownButton<String>(
                              hint: Text('Escolha seu curso'),
                              value: _course,
                              onChanged: (String course) {
                                setState(() {
                                  _course = course;
                                });
                              },
                              items: courseList.map((Course course) {
                                return DropdownMenuItem<String>(
                                  value: course.acronym,
                                  child: Text(course.acronym),
                                );
                              }).toList(),
                            ));
                      }
                    }),
                Visibility(
                    visible: visibilityRA,
                    child: MaskedTextField(
                        maskedTextFieldController: _textRAController,
                        maxLength: 12,
                        keyboardType: TextInputType.number,
                        inputDecoration: new InputDecoration(
                          labelText: 'RA',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                        ))),
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
                          update();
                        },
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
                      ),
                    )),
                //       child: InkWell(
                // ],
                // )),
              ]))
        ]));
  }

  Future<void> getValues() async {
    final getUser =
        await UserController().show(widget.user.id, widget.user.token);
    User values = User.fromJson(getUser, widget.user.token);
    _textNameController.text = values.name;
    _textCPFController.text = values.cpf;
    _textPasswordController.text = values.password;
    _textEmailController.text = values.email;
  }

  Future<void> update() async {
    var _name = _textNameController.text,
        _password = _textPasswordController.text,
        _email = _textEmailController.text;

    ResponseHandling().validateEmail(_email);
    ResponseHandling().validatePassword(_password);

    try {
      var jsonData =
          '{ "name" : "$_name", "email" : "$_email", "password" : "$_password" }';
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
