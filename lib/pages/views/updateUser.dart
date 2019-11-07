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
import 'package:gradient_widgets/gradient_widgets.dart';
import 'common/CustomShapeClipper.dart';

class UserScreenTopPart extends StatefulWidget {
  @override
  _UserScreenTopPartState createState() => _UserScreenTopPartState();
}

class _UserScreenTopPartState extends State<UserScreenTopPart> {
  String title = "Perfil";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: Colors.red,
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
          elevation: 0,
          // title: new Text('Perfil',
          //     style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))
        ),
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: <
                    Widget>[
          UserScreenTopPart(),
          Container(
              // color: Colors.white,
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Column(children: <Widget>[
                TextField(
                  controller: _textNameController,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Nome Completo',
                    border: InputBorder.none,
                    // border: InputBorder(borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    // fillColor: const Color.fromARGB(255, 244, 244, 244),
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Colors.white,
                    // border: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    labelStyle: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),

                    // focusedBorder: UnderlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.white))
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _textEmailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      labelStyle: TextStyle(
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(height: 8.0),
                MaskedTextField(
                  maskedTextFieldController: _textCPFController,
                  mask: "xxx.xxx.xxx-xx",
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  inputDecoration: new InputDecoration(
                      fillColor: const Color.fromARGB(255, 244, 244, 244),
                      filled: true,
                      enabled: false,
                      labelText: 'CPF',
                      labelStyle: TextStyle(
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      ))),
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
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'RA',
                      labelStyle: TextStyle(
                          fontFamily: 'Noto',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      // focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.white)),
                    )),
                SizedBox(height: 10.0),
                // Container(
                //   color: Colors.redAccent,
                Row(
                  children: <Widget>[
                    Material(
                      // borderRadius: BorderRadius.circular(20.0),
                      // color: Colors.white,
                      // elevation: 7.0,
                      child: GradientButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        callback: () {
                          this.update();
                        },
                        increaseWidthBy: 80.0,
                        increaseHeightBy: 30.0,
                        gradient: Gradients.blush,
                        child: Center(
                          child: Text(
                            'Atualizar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                fontFamily: 'Noto'),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20.0),

                    // height: 40.0,
                    Material(
                      // borderRadius: BorderRadius.circular(20.0),
                      // color: Colors.white,
                      // elevation: 7.0,
                      child: GradientButton(
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
                        gradient: Gradients.blush,
                        increaseWidthBy: 80.0,
                        increaseHeightBy: 30.0,
                        child: Center(
                          child: Text(
                            'Mudar Senha',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                fontFamily: 'Noto'),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]))
        ])));
  }

  getValues() {
    _textNameController.text = widget.user.name;
    _textCPFController.text = widget.user.cpf;
    _textEmailController.text = widget.user.email;
    if (widget.user.student != null) {
      _textRAController.text = widget.user.student.ra;
      _isChecked = true;
      _course = widget.user.student.course.acronym;
    }
  }

  Future<void> update() async {
    var _name = _textNameController.text,
        _email = _textEmailController.text,
        _ra = _textRAController.text;
    ResponseHandling().validateEmail(_email);
    try {
      var jsonData = '{ "name" : "$_name", "email" : "$_email"';
      if (widget.user.student == null && _isChecked ||
          widget.user.student != null) {
        int courseId;
        for (var course in courseList) {
          if (course.acronym == _course) {
            courseId = course.id;
          }
        }
        if (ResponseHandling().validateRA(_ra) && courseId != 0) {
          jsonData += ', "ra" : "$_ra", "courseId" : "$courseId"';
        }
      }
      jsonData += ' }';
      final update = await UserController()
          .update(widget.user.id, jsonData, widget.user.token);
      User user = User.fromJson(update, widget.user.token);

      Fluttertoast.showToast(
          msg: "Cadastro atualizado com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(user: user)));
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
