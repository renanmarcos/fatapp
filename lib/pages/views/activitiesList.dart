import 'package:fatapp/pages/models/acitivity.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:flutter/material.dart';
import './common/CustomShapeClipper.dart';
import './activityDetail.dart';
import 'package:fatapp/pages/controllers/activityController.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        // title: new Text('Palestras e Atividades'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          ActivitiesListTopPart(),
          ActivityFilter(),
          ActivitiesListContent(),
        ],
      ),
    );
  }
}

class ActivitiesListTopPart extends StatefulWidget {
  @override
  _ActivitiesListTopPartState createState() => _ActivitiesListTopPartState();
}

class _ActivitiesListTopPartState extends State<ActivitiesListTopPart> {
  String title = "Atividades";

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
                  padding: const EdgeInsets.fromLTRB(50.0, 10.0, 0.0, 10.0),
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

class ActivitiesListContent extends StatefulWidget {
  @override
  _ActivitiesListContentState createState() => _ActivitiesListContentState();
}

class _ActivitiesListContentState extends State<ActivitiesListContent> {
  List<Activity> activities = List();
  var isLoading = true;

  _fetchData() async {
    activities = await ActivityController().index("");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: activities.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityDetail()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text(activities[index].title,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 18.0)),
              subtitle: Text(activities[index].speaker.name),
            ),
          ),
        );
      },
    );
  }
}

class ActivityFilter extends StatefulWidget {
  ActivityFilter({Key key}) : super(key: key);

  @override
  _ActivityFilterState createState() => new _ActivityFilterState();
}

class _ActivityFilterState extends State<ActivityFilter> {
  List _dates = ["17/04", "18/04"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentDate;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentDate = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String date in _dates) {
      items.add(new DropdownMenuItem(value: date, child: new Text(date)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 30.0),
      child: new Center(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Escolha uma data',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Raleway', fontSize: 18.0)),
          new Container(
            padding: new EdgeInsets.all(5.0),
          ),
          new DropdownButton(
            value: _currentDate,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          )
        ],
      )),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentDate = selectedCity;
    });
  }
}
