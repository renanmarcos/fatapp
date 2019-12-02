import 'dart:convert';
import 'package:fatapp/pages/controllers/courseController.dart';
import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/studentController.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/course.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:masked_text/masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/CustomShapeClipper.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: const Color(0xFFCE0000),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          RegisterTopPart(),
          Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(children: <Widget>[
                TextField(
                  controller: _textNameController,
                  decoration: InputDecoration(
                      labelText: 'Nome Completo',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
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
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
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
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                MaskedTextField(
                  maskedTextFieldController: _textCPFController,
                  mask: "xxx.xxx.xxx-xx",
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  inputDecoration: new InputDecoration(
                      labelText: 'CPF',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                CheckboxListTile(
                    title: Text("Você é um estudante da FATEC?"),
                    value: _isChecked,
                    activeColor: const Color(0xFFCE0000),
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
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.red)));
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
                        maxLength: 13,
                        keyboardType: TextInputType.number,
                        inputDecoration: new InputDecoration(
                          labelText: 'RA',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ))),
                SizedBox(height: 10.0),
                Container(
                    height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GradientButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        increaseWidthBy: 50.0,
                        increaseHeightBy: 10.0,
                        gradient: Gradients.buildGradient(
                            Alignment.topLeft,
                            Alignment.bottomRight,
                            [const Color(0xFFCE0000), const Color(0xFFB71C1C)]),
                        callback: () {
                          register();
                        },
                        child: Center(
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 30.0)
              ]))
        ])));
  }

  Future<void> register() async {
    User user;
    var _name = _textNameController.text,
        _cpf = _textCPFController.text,
        _password = _textPasswordController.text,
        _email = _textEmailController.text,
        _ra = _textRAController.text;
    if (!ResponseHandling().validateEmail(_email) ||
        !ResponseHandling().validatePassword(_password) ||
        !ResponseHandling().validateCPF(_cpf)) {
      return;
    }
    try {
      var created;
      if (visibilityRA) {
        int courseId;
        for (var course in courseList) {
          if (course.acronym == _course) {
            courseId = course.id;
          }
        }
        if (!ResponseHandling().validateRA(_ra)) {
          return;
        }
        var jsonStudent =
            '{ "name" : "$_name", "cpf" : "$_cpf", "email" : "$_email", "password" : "$_password", "ra" : "$_ra", "courseId" : "$courseId" }';
        created = await StudentController().create(jsonStudent);
        user = User.createWithStudent(created);
      } else {
        var jsonUser =
            '{ "name" : "$_name", "cpf" : "$_cpf", "email" : "$_email", "password" : "$_password" }';
        created = await UserController().create(jsonUser);
        user = User.create(created);
      }
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      String userString = json.encode(created);
      sharedUser.setString('user', userString);

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

class RegisterTopPart extends StatefulWidget {
  @override
  _RegisterTopPartState createState() => _RegisterTopPartState();
}

class _RegisterTopPartState extends State<RegisterTopPart> {
  String title = "Cadastro";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: const Color(0xFFCE0000),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                          color: Colors.white,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Hero(
                          tag: "hero",
                          child: Container(
                            padding: EdgeInsets.only(top: 50.0),
                            height: 80.0,
                            width: 80.0,
                            // child: logo,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
