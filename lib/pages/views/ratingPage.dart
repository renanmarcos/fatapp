import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:fatapp/pages/controllers/activityController.dart';
import 'package:fatapp/pages/models/acitivity.dart';

class RatingStar extends StatefulWidget {
  const RatingStar({this.activity,this.user});
  final Activity activity;
  final User user;

  @override
  _RatingStarState createState() => _RatingStarState();

  
}

class _RatingStarState extends State<RatingStar> {
  RatingStar rate =  RatingStar();
  var rating = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating bar demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
          backgroundColor: const Color(0xFFCE0000),
          title: Text('Avaliação'),
          elevation: 0,
        ),
        body: Center(
          child: new ListView(
            shrinkWrap: true,
            
            padding: const EdgeInsets.all(50.0),
            
            children: <Widget>[
            Text('Dê uma nota para o evento: ' + widget.activity.title,
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
             ),
             SizedBox(height: 45.0),
             Center(
              child: 
                 SmoothStarRating(
                  rating: rating,
                  size: 45,
                  starCount: 5,
                  spacing: 2.0,
                  borderColor: Colors.redAccent,
                  color: Colors.yellow,
                  onRatingChanged: (value) {
                  setState(() {
                    rating = value;
                    this.rateActivity(rating, widget.user.id, widget.user.token);
                  });
                },
             )),
            ]
          )
        )
      ),
    );
  }

  void rateActivity(ratingValue, userId, token) {
    var jsonRate = '{ "userId" : "$userId", "numberOfStars" : "$ratingValue"}';
    ActivityController().rateActivity(widget.activity.id, jsonRate, token);
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => HomePage(user: widget.user))); 
    Fluttertoast.showToast(
      msg:
        "Avaliação enviada com sucesso!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
