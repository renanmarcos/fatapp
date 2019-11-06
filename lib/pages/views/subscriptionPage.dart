import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/subscription.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:fatapp/pages/views/activityDetail.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  SubscriptionPage(this.user);
  final User user;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Inscrições')),
      body: SubscriptionsContainer(user),
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
      return Center(child: Text("Sem inscrições"));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _subscriptions.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
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
                      fontSize: 18.0)),
              subtitle: Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(_subscriptions[index].attended
                      ? "Participou"
                      : "Não participou")),
            ),
          ),
        );
      },
    );
  }
}
