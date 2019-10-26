import 'package:flutter/material.dart';
import './common/CustomShapeClipper.dart';
class ActivityDetail extends StatefulWidget {
  ActivityDetail({Key key}) : super(key: key);

  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  String nameActivity = 'DataBase';
  String description = 'lalalalalalllaasokdfjfkijfvnrjvnaleurith';
  String time = '09:00';
  String day = '17/04';
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
        children: <Widget>[
          SizedBox(height: 5.0,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text(nameActivity),
                Text(description),
                Text(time),
                Text(day)
              ],
            ),
          ),
        ],
       ),
    );
  }
}

class ActivityDetailTopPart extends StatefulWidget {
  @override
  _ActivityDetailTopPartState createState() => _ActivityDetailTopPartState();
}

class _ActivityDetailTopPartState extends State<ActivityDetailTopPart> {
  String subtitle = "Palestra sobre";
  String title = "Flutter";
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(height: 150.0, color: Colors.red, 
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Text(subtitle,
                      style: TextStyle(fontSize: 12.0, 
                        fontWeight: FontWeight.w300,
                        color: Colors.white10,
                        fontFamily: 'Noto',
                      ),
                    ),
                    Text(title,
                      style: TextStyle(fontWeight: FontWeight.w800,    
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