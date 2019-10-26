import 'package:fatapp/pages/controllers/courseController.dart';
import 'package:fatapp/pages/controllers/studentController.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/course.dart';
import 'package:fatapp/pages/models/student.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masked_text/masked_text.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Course _course;
  User user;

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
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                  child: Text(
                    'Cadastro',
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
                          List<Course> courseList = snapshot.data;
                          return Visibility(
                              visible: visibilityCourse,
                              child: DropdownButton<Course>(
                                hint: Text('Escolha seu curso'),
                                value: _course,
                                onChanged: (Course course) {
                                  setState(() {
                                    _course = course;
                                  });
                                },
                                items: courseList.map((Course course) {
                                  return DropdownMenuItem(
                                    value: course,
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
                          register();
                        },
                        color: Colors.redAccent,
                        child: Center(
                          child: Text(
                            'Cadastrar',
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
  Future<void> register() async {
    try {
      this.createUser();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(user: this.user)));
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

  Future<void> createUser() async {
    var _name = _textNameController.text,
        _cpf = _textCPFController.text,
        _password = _textPasswordController.text,
        _email = _textEmailController.text,
        _ra = _textRAController.text;
    int courseId = _course.id;
    if (visibilityRA) {
      var jsonStudent =
        '{ "name" : "$_name", "cpf" : "$_cpf", "email" : "$_email", "password" : "$_password", "ra" : "$_ra", "courseId" : "$courseId"}';
      final created = await StudentController().create(jsonStudent);
      Student student = Student.fromJson(created);
      this.user = student.user;
    } else {
      var jsonUser =
          '{ "name" : "$_name", "cpf" : "$_cpf", "email" : "$_email", "password" : "$_password" }';
      final created = await UserController().create(jsonUser);
      this.user = User.fromJson(created);
    }
  }
}
