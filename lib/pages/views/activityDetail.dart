import 'package:flutter/material.dart';
import 'common/CustomShapeClipper.dart';

class ActivityDetailTopPart extends StatefulWidget {
  ActivityDetailTopPart({Key key}) : super(key: key);

  @override
  _ActivityDetailTopPartState createState() => _ActivityDetailTopPartState();
}

class _ActivityDetailTopPartState extends State<ActivityDetailTopPart> {
  String title = "Palestra X";

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
                        title,
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

class ActivityDetail extends StatelessWidget {
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
                    'Nome da Palestra',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                Text(
                  'Nome do Palestrante',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'Raleway',
                  ),
                ),
                Text(
                  '14:00',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.yellow[500],
          ),
          Text('5'),
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
          'Palestra super legal',
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
        // title: Text('Palestra X'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          ActivityDetailTopPart(),
          // Image.asset(
          //   'images/lake.jpg',
          //   width: 600,
          //   height: 240,
          //   fit: BoxFit.cover,
          // ),
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
