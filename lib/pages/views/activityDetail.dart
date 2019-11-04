import 'package:fatapp/pages/models/acitivity.dart';
import 'package:flutter/material.dart';
import 'common/CustomShapeClipper.dart';
import 'package:intl/intl.dart';

class ActivityDetailTopPart extends StatefulWidget {
  ActivityDetailTopPart(this.title);
  final String title;

  @override
  _ActivityDetailTopPartState createState() => _ActivityDetailTopPartState();
}

class _ActivityDetailTopPartState extends State<ActivityDetailTopPart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: Colors.red,
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Text(
                        widget.title,
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
                              width: 80.0),
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

class ActivityDetail extends StatelessWidget {
  const ActivityDetail(this.activity);
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    this.activity.speaker.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    this.activity.speaker.curriculum,
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                Text(
                  DateFormat("dd/MM 'às' HH:mm")
                          .format(this.activity.initialDate.toLocal()) +
                      " até " +
                      DateFormat("dd/MM 'às' HH:mm")
                          .format(this.activity.finalDate.toLocal()),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.event, 'Inscreva-se'),
          _buildButtonColumn(color, Icons.share, 'Compartilhe'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Card(
          child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
        child: new Text(
          this.activity.description,
          softWrap: true,
        ),
      )),
    );

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          ActivityDetailTopPart(this.activity.title),
          titleSection,
          buttonSection,
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
