import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class Course{
  int id;
  String name;

  Course(this.id,this.name);

  static List<Course> getList(){
    return<Course>[Course(1,'ADSMA1'),Course(2,'ADSMA2'),Course(4,'ADSMA3'),Course(4,'ADSMA4'),Course(4,'ADSMA5'),Course(4,'ADSMA6'),
    Course(4,'ADSVA1'),Course(4,'ADSVA2'),Course(4,'ADSVA3'),Course(4,'ADSVA4'),Course(4,'ADSVA5'),Course(4,'ADSVA6'),
    Course(4,'SEGMA1'),Course(4,'SEGMA2'),Course(4,'SEGMA3'),Course(4,'SEGMA4'),Course(4,'SEGMA5'),Course(4,'SEGMA6'),
    Course(4,'SEGNA1'),Course(4,'SEGNA2'),Course(4,'SEGNA3'),Course(4,'SEGNA4'),Course(4,'SEGNA5'),Course(4,'SEGNA6'),
    Course(4,'COMEX1'),Course(4,'COMEX2'),Course(4,'COMEX3'),Course(4,'COMEX4'),Course(4,'COMEX5'),Course(4,'COMEX6'),
    Course(4,'JOGNA1'),Course(4,'JOGNA2'),Course(4,'JOGNA3'),Course(4,'JOGNA4'),Course(4,'JOGNA5'),Course(4,'JOGNA6')] ;
  }

}

class _SignupPageState extends State<SignupPage> {

  List<Course> _CourseList = Course.getList();
  List<DropdownMenuItem<Course>> _dropdownMenuItems;
  Course _selectedCourse;
  @override
  void initState(){
    _dropdownMenuItems = buildDropdownMenuItems(_CourseList);
    _selectedCourse = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<Course>> buildDropdownMenuItems(List courseList){
    List<DropdownMenuItem<Course>> items = List();
    for (Course course in courseList){
      items.add(DropdownMenuItem(
        value: course,
        child: Text(course.name),
      ),
      );
    }
    return items;
  }



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
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Cadastro',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Nome Completo',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'Nome Completo',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Email ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
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
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'RA',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  new Container(
                    child: Center(
                    child:Column(
                      children:<Widget>[
                        //Text("Selecione Sua Turma"),
                        SizedBox(height:20.0),
                        DropdownButton(
                          value: _selectedCourse,
                          items: _dropdownMenuItems, onChanged: (Course value) {},
                        ),
                      ]
                    )
                  )
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.redAccent,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
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
        ]))]));
  }
}