import 'package:fatapp/pages/models/event.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/activitiesList.dart';
import 'package:flutter/material.dart';
import 'common/CustomShapeClipper.dart';

class EventDetailTopPart extends StatefulWidget {
  EventDetailTopPart({Key key}) : super(key: key);

  @override
  _EventDetailTopPartState createState() => _EventDetailTopPartState();
}

class _EventDetailTopPartState extends State<EventDetailTopPart> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: Colors.red,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Evento",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                          color: Colors.white,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Hero(
                          tag: "hero",
                          child: Container(
                            padding: EdgeInsets.only(top: 50.0),
                            height: 80.0,
                            width: 80.0,
                            // child: logo,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class EventDetail extends StatelessWidget {
  const EventDetail({this.user, this.event});
  final User user;
  final Event event;
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    this.event.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                // Text(
                //   'Nome do Palestrante',
                //   style: TextStyle(
                //     color: Colors.grey[500],
                //     fontFamily: 'Raleway',
                //   ),
                // ),
                Text(
                  this.event.edition,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          /*3*/

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivitiesList()),
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButtonColumn(
                      Colors.grey[500], Icons.event, 'Palestras'),
                  // _buildButtonColumn(color, Icons.share, 'Compartilhe'),
                ],
              ),
            ),
          ),

          // Icon(
          //   Icons.star,
          //   color: Colors.yellow[500],
          // ),
          // Text('5'),
        ],
      ),
    );

    // Color color = Theme.of(context).primaryColor;

    // Widget buttonSection = Container(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       _buildButtonColumn(color, Icons.event, 'Palestras'),
    //       // _buildButtonColumn(color, Icons.share, 'Compartilhe'),
    //     ],
    //   ),
    // );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Card(
          child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
        child: new Text(
          this.event.description,
          softWrap: true,
        ),
      )

          // 'Palestra super foda',
          //
          ),
    );

    return new Scaffold(
      // title: 'Palestra X',
      // home: Scaffold(
      appBar: AppBar(
        title: new Text(this.event.title),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          // EventDetailTopPart(),
          Image.network(
            this.event.imageUrl,
            headers: {
              "Token" : this.user.token
            },
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          // buttonSection,
          textSection,
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.red),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
