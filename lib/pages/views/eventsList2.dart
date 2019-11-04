import 'package:fatapp/pages/models/user.dart';
import 'package:flutter/material.dart';
import './currenEvent.dart';
import './pastEvents.dart';

class EventsList extends StatelessWidget {
  const EventsList({this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              tabs: [
                Tab(
                  // icon: Icon(Icons.check_box),
                  text: 'Evento Atual',
                ),
                Tab(
                  // icon: Icon(Icons.history),
                  text: 'Eventos Passados',
                ),
              ],
            ),
            title: Text(
              'Eventos',
              style: TextStyle(fontFamily: 'Noto'),
            ),
            backgroundColor: Colors.red,
          ),
          body: TabBarView(
            children: [
              CurrentEvent(user: this.user),
              PastEvents(),
            ],
          ),
        ),
      ),
    );
  }
}
