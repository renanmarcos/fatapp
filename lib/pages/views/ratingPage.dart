import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
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
    return Scaffold(
          appBar: AppBar(
          backgroundColor: const Color(0xFFCE0000),
          title: Text('Avaliação'),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Column(children: <Widget>[
                  new ListView(
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
                            this.rating = value;
                          });
                        },
                    )),
                    SizedBox(height: 50.0),
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
                              Alignment.topLeft, Alignment.bottomRight, [
                              const Color(0xFFCE0000),
                              const Color(0xFFB71C1C)
                            ]),
                            callback: () async {
                              this.rateActivity(this.rating, widget.user.id, widget.user.token);
                            },
                              child: Center(
                                child: Text(
                                  'Avaliar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                  ]
                )]
              )
            )
        ])
      )
    );
  }

  Future<void> rateActivity(ratingValue, userId, token) async {
    var jsonRate = '{ "userId" : "$userId", "numberOfStars" : "$ratingValue"}';
    await ActivityController().rateActivity(widget.activity.id, jsonRate, token);
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
