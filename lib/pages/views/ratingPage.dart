import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:fatapp/pages/controllers/activityController.dart';

class RatingStar extends StatefulWidget {

  const RatingStar({this.activityId,this.token,this.userId});
  final activityId;
  final token;
  final userId;


  @override
  _RatingStarState createState() => _RatingStarState();

  
}

class _RatingStarState extends State<RatingStar> {
  RatingStar rate =  RatingStar();
  

  var rating = 0.0;
  var activity;

  @override
  void initState() {
    activity = ActivityController().getActivity(rate.activityId, rate.token);
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
             Text('Dê uma nota para $activity.title',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
             ),
                 SmoothStarRating(
            title: Text(''),
            elevation: 0,
            backgroundColor: Colors.red,
          ),
          body: Center(
              child: new ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(50.0),
                  children: <Widget>[
                Text(
                  'Dê uma nota para BIGDATA',
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
                    this.rateActivity(rating, this.rate.userId, this.rate.token);
                  });
                },
             ),
            ]
          )
        )
      ),
                    setState(() {
                      rating = value;
                    });
                  },
                ),
              ]))),
    );
  }

  void rateActivity(ratingValue,userId,token){

    var jsonRate = '{ "userId" : "$userId", "numberOfStars" : "$ratingValue"}';


    ActivityController().rateActivity(this.activity.id, jsonRate, token);
    

  }
}
