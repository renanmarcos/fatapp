import 'package:fatapp/pages/controllers/courseController.dart';
import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/course.dart';
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
  String _course;
  List<Course> courseList;
  bool _isChecked = false;
  
  TextEditingController _textRAController = new TextEditingController();
  TextEditingController _textEmailController = new TextEditingController();
  TextEditingController _textNameController = new TextEditingController();
  TextEditingController _textCPFController = new TextEditingController();
  void initState() {
    this.getValues();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        appBar: new AppBar(
          title: new 
            Text('Perfil', 
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
          )
        ),
        resizeToAvoidBottomPadding: false,
        body:  SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
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
                SizedBox(height: 8.0),
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
                SizedBox(height: 8.0),
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
                SizedBox(height: 10.0),
                CheckboxListTile(
                    title: Text("Você é um estudante da FATEC?"),
                    value: _isChecked,
                    onChanged: (val) {
                      setState(() {
                        _isChecked = val;
                      });
                    }),
                FutureBuilder<List<Course>>(
                    future: CourseController().getCourses(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        courseList = snapshot.data;
                        return DropdownButton<String>(
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
                        );
                      }
                    }),
                MaskedTextField(
                    maskedTextFieldController: _textRAController,
                    maxLength: 13,
                    keyboardType: TextInputType.number,
                    inputDecoration: new InputDecoration(
                      labelText: 'RA',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    )),
                SizedBox(height: 10.0),
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
                          this.update();
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
              ]))
        ])
      )
    );
  }

  getValues() {
    _textNameController.text = widget.user.name;
    _textCPFController.text = widget.user.cpf;
    _textEmailController.text = widget.user.email;
    if (widget.user.student != null) {
      _textRAController.text = widget.user.student.ra;
      _isChecked = true;
      //_course = widget.user.student.course.acronym;
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
      Fluttertoast.showToast(
          msg: "Cadastro atualizado com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(user: user)));
      //Falta ajustar estudante
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
