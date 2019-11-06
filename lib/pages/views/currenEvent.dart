import 'package:fatapp/pages/controllers/eventController.dart';
import 'package:fatapp/pages/models/event.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/eventDetail.dart';
import 'package:flutter/material.dart';

class CurrentEvent extends StatelessWidget {
  const CurrentEvent(this.user);
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
          eventList = eventList.where((event) =>
            event.finalDate.toLocal().add(Duration(hours: 1)).isAfter(DateTime.now().toLocal()))
            .toList();
          }
          return ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.all(15.0),
                child: InkWell(
                  splashColor: Colors.red.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventDetail(this.user, eventList[index])),
                    );
                  },
                  child: ListTile(
                    title: new Text(eventList[index].title,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 18.0)),
                    subtitle: Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(eventList[index].description)),
                  )
                )
              );     
            }
          );
        }
      );        
    }
}