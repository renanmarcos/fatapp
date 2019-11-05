import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingStar extends StatefulWidget {
  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {

  var rating = 0.0;

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
             Text('Dê uma nota para BIGDATA',
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
                  });
                },
             ),
            ]
          )
        )
      ),
    );
  }
}