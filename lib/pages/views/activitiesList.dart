import 'package:fatapp/pages/models/acitivity.dart';
import 'package:fatapp/pages/models/event.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/activityDetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fatapp/pages/controllers/activityController.dart';
import 'common/CustomShapeClipper.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList(this.user, this.event);
  final User user;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFCE0000),
      ),
      body: Column(children: <Widget>[
        ActivitiesListTopPart(),
        ActivitiesContainer(this.user, this.event)
      ]),
    );
  }
}

class ActivitiesListTopPart extends StatefulWidget {
  @override
  _ActivitiesListTopPartState createState() => _ActivitiesListTopPartState();
}

class _ActivitiesListTopPartState extends State<ActivitiesListTopPart> {
  final String title = "Atividades";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: const Color(0xFFCE0000),
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

class ActivitiesContainer extends StatefulWidget {
  ActivitiesContainer(this.user, this.event);
  final User user;
  final Event event;

  @override
  _ActivitiesContainerState createState() => _ActivitiesContainerState();
}

class _ActivitiesContainerState extends State<ActivitiesContainer> {
  List<Activity> _activities = List();
  var _isLoading = true;

  _fetchData() async {
    _activities = await ActivityController()
        .indexFromEvent(widget.event, widget.user.token);

    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    _fetchData();

    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_activities.isEmpty) {
      return Center(child: Text("Não existem atividades para esse evento."));
    }

    return ActivityFilter(_activities, widget.user);
  }
}

class ActivityFilter extends StatefulWidget {
  ActivityFilter(this.activities, this.user);
  final List<Activity> activities;
  final User user;

  @override
  _ActivityFilterState createState() => new _ActivityFilterState();
}

class _ActivityFilterState extends State<ActivityFilter> {
  List _dates;
  List _filteredActivities;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentDate;

  @override
  void initState() {
    _dates = widget.activities
        .map((activity) => DateFormat("dd/MM").format(activity.initialDate))
        .toList();
    _dropDownMenuItems = getDropDownMenuItems();
    _currentDate = _dropDownMenuItems[0].value;
    _filteredActivities = widget.activities
        .where((activity) =>
            DateFormat("dd/MM").format(activity.initialDate) == _currentDate)
        .toList();
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
    return Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 30.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Escolha uma data',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                    fontSize: 18.0)),
            Container(
              padding: EdgeInsets.all(5.0),
            ),
            DropdownButton(
              value: _currentDate,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            )
          ],
        )),
      ),
      ActivitiesListContent(_filteredActivities, widget.user)
    ]);
  }

  void changedDropDownItem(String selectedDate) {
    setState(() {
      _currentDate = selectedDate;
      _filteredActivities = widget.activities
          .where((activity) =>
              DateFormat("dd/MM").format(activity.initialDate.toLocal()) ==
              _currentDate)
          .toList();
    });
  }
}

class ActivitiesListContent extends StatefulWidget {
  ActivitiesListContent(this.activities, this.user);
  final List<Activity> activities;
  final User user;

  @override
  _ActivitiesListContentState createState() => _ActivitiesListContentState();
}

class _ActivitiesListContentState extends State<ActivitiesListContent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.activities.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ActivityDetail(widget.activities[index], widget.user)),
              );
            },
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              title: Text(widget.activities[index].title,
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900)),
              subtitle: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(widget.activities[index].speaker.name)),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.access_time),
                    Text(DateFormat("HH:mm")
                        .format(widget.activities[index].initialDate.toLocal()))
                  ]),
            ),
          ),
        );
      },
    );
  }
}
