import 'package:flutter/material.dart';
import './common/CustomShapeClipper.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Palestras e Atividades'),
      ),
    );
  }
}
class ActivitiesListTopPart extends StatefulWidget {
  @override
  _ActivitiesListTopPartState createState() => _ActivitiesListTopPartState();
}

class _ActivitiesListTopPartState extends State<ActivitiesListTopPart> {
  String title = "Palestras e Atividades";
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(height: 150.0, color: Colors.red, 
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 5.0, 60.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Text(title,
                      style: TextStyle(fontWeight: FontWeight.w800,    
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

class ActivitiesListContent extends StatelessWidget {
  const ActivitiesListContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = ['Database', 'Bigdata', 'React Native', 'Flutter'];
    final professors = ['Rogerio Albino', 'Flávia Amaral', 'Gabriel Ulisses','Soraya de Campos'];
    final time = ['09:00', '10:00', '11:00', '12:00'];
    final rooms = ['01', '02', '04', '07'];
    return ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Card( 
            elevation: 2.0,
            margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: InkWell(
              splashColor: Colors.red.withAlpha(30),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => PastEventsYears()),
                // );
              },
            child: ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text(events[index], 
              style: TextStyle(color: Colors.black, fontFamily: 'Raleway',
              fontSize: 18.0)),
              subtitle: Text(professors[index]),
            ),
          ),
        );
      },
    );
  }
}
