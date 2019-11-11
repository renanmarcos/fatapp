import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/subscription.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:flutter/material.dart';
import 'activityDetail.dart';
import 'common/CustomShapeClipper.dart';

class SubscriptionPage extends StatelessWidget {
  SubscriptionPage(this.user);
  final User user;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: const Color(0xFFCE0000),
        elevation: 0,
      ),
      body: Column(children: <Widget>[
        SubscriptionsListTopPart(),
        SubscriptionsContainer(user),
      ]),
    );
  }
}

class SubscriptionsContainer extends StatefulWidget {
  SubscriptionsContainer(this.user);
  final User user;

  @override
  _SubscriptionsContainerState createState() => _SubscriptionsContainerState();
}

class _SubscriptionsContainerState extends State<SubscriptionsContainer> {
  bool _isLoading = true;
  List<Subscription> _subscriptions;

  _fetchData() async {
    _subscriptions = await UserController().subscriptions(widget.user);
    _subscriptions = _subscriptions
        .where((subscription) => DateTime.now().isBefore(subscription
            .activity.initialDate
            .toLocal()
            .add(Duration(hours: 1))))
        .toList();

    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();

    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_subscriptions.length == 0) {
      return Center(
        child: Text("Sem inscrições"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _subscriptions.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: InkWell(
            splashColor: const Color(0xFFCE0000),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ActivityDetail(
                          _subscriptions[index].activity, widget.user)),
                );
              },
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              title: Text(_subscriptions[index].activity.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                      fontSize: 18.0))
            ),
          ),
        );
      },
    );
  }
}

class SubscriptionsListTopPart extends StatefulWidget {
  @override
  _SubscriptionsListTopPartState createState() => _SubscriptionsListTopPartState();
}

class _SubscriptionsListTopPartState extends State<SubscriptionsListTopPart> {
  String title = "Inscrições";

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