import 'package:flutter/material.dart';
// import './activitiesList.dart';
import './ratingPage.dart';

class PastEvents extends StatelessWidget {
  const PastEvents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = ['Fatecnologia 2018', 'ADS Day 2018', 'Comex Day 2018', 'Games Day 2018'];

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RatingStar()),
              );
            },
            child: ListTile(
              title: Text(events[index],
                  style: TextStyle(
                      color: Colors.black45,
                      fontFamily: 'Noto',
                      fontSize: 18.0)),
            ),
          ),
        );
      },
    );
  }
}
