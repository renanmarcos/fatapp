import 'package:fatapp/pages/controllers/eventController.dart';
import 'package:fatapp/pages/models/event.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:flutter/material.dart';

class CurrentEvent extends StatelessWidget {
  const CurrentEvent({this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:EventController().getEvents(this.user.token),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Event> eventList;
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          eventList = snapshot.data;
          eventList.where((event) =>
            event.initialDate.toLocal().isBefore(DateTime.now().toLocal()))
            .toList();
          }
          return ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (BuildContext context, int index) {
              return new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(eventList[index].title),
                  ),
                  new Divider(height: 2.0),
                ]
              );
            }
          );
        }
      );        
    }
}