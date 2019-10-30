import 'package:flutter/material.dart';
import './pastEventsYears.dart';

class PastEvents extends StatelessWidget {
  const PastEvents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = ['Fatecnologia', 'ADS Day', 'Comex Day', 'Games Day'];

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
                MaterialPageRoute(builder: (context) => PastEventsYears()),
              );
            },
            child: ListTile(
              title: Text(events[index],
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 18.0)),
            ),
          ),
        );
      },
    );
  }
}
