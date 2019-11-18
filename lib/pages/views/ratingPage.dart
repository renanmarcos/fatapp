import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
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
          title: Text(''),
          elevation: 0,
          backgroundColor: Colors.red,
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
             ),
            ]
          )
        )
      ),
    );
  }

  void rateActivity(ratingValue, userId, token) async {
    var userId = widget.user.id;
    var jsonRate = '{ "userId" : "$userId", "numberOfStars" : "$ratingValue"}';
    await ActivityController().rateActivity(widget.activity.id, jsonRate, token);
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => HomePage(user: widget.user))); 
  }
}
