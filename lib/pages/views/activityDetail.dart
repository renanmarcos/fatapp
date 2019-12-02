import 'dart:convert';
import 'package:fatapp/pages/controllers/activityController.dart';
import 'package:fatapp/pages/controllers/userController.dart';
import 'package:fatapp/pages/models/acitivity.dart';
import 'package:fatapp/pages/models/subscription.dart';
import 'package:fatapp/pages/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'common/CustomShapeClipper.dart';
import 'package:intl/intl.dart';

class ActivityDetailTopPart extends StatefulWidget {
  ActivityDetailTopPart(this.title);
  final String title;

  @override
  _ActivityDetailTopPartState createState() => _ActivityDetailTopPartState();
}

class _ActivityDetailTopPartState extends State<ActivityDetailTopPart> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 150.0,
            color: const Color(0xFFCE0000),
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
                      Text(widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 24.0,
                            color: Colors.white,
                            fontFamily: 'Raleway',
                          )),
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
  const ActivityDetail(this.activity, this.user);
  final Activity activity;
  final User user;

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
                  DateFormat("dd/MM 'às' HH:mm").format(this
                          .activity
                          .initialDate
                          .toLocal()) +
                      " até " +
                      DateFormat("dd/MM 'às' HH:mm").format(this
                          .activity
                          .finalDate
                          .toLocal()),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  this.activity.room.type + " " + this.activity.room.name,
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

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Card(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 35.0),
        child: new Text(
          this.activity.description,
          softWrap: true,
        ),
      )),
    );

    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFCE0000),
      ),
      body: ListView(
        children: <Widget>[
          ActivityDetailTopPart(this.activity.title),
          titleSection,
          ActivityActions(this.activity, this.user),
          textSection
        ],
      ),
    );
  }
}

class ActivityActions extends StatefulWidget {
  ActivityActions(this.activity, this.user);
  final Activity activity;
  final User user;

  @override
  _ActivityActionsState createState() => _ActivityActionsState();
}

class _ActivityActionsState extends State<ActivityActions> {
  bool subscribed = false;
  bool isLoading = true;
  Subscription _filteredSubscription;
  List<Subscription> _subscriptions;

  _fetchData() async {
    _subscriptions = await UserController().subscriptions(widget.user);
    _filteredSubscription = _subscriptions.firstWhere(
        (subscription) => subscription.activity.id == widget.activity.id,
        orElse: () => null);

    if (null != _filteredSubscription && this.isLoading) {
      setState(() {
        subscribed = true;
        isLoading = false;
      });
    }

    if (this.isLoading) {
      setState(() {
        subscribed = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();

    if (isLoading) {
      return Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)
      ));
    }

    Color color = Theme.of(context).primaryColor;
    GestureDetector subscribeButton = _buildSubscribeButton(subscribed, color);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          subscribeButton,
          _buildButtonColumn(color, Icons.share, 'Compartilhe', share),
        ],
      ),
    );
  }

  GestureDetector _buildSubscribeButton(bool subscribed, Color color) {
    if (DateTime.now().isAfter(
        widget.activity.initialDate.toLocal().add(Duration(hours: 1)))) {
      return _buildButtonColumn(
          color, Icons.warning, 'Atividade encerrada', null);
    }

    if (subscribed) {
      return _buildButtonColumn(
          color, Icons.close, 'Cancelar inscrição', cancelSubscription);
    }

    return _buildButtonColumn(color, Icons.event, 'Inscreva-se', subscribe);
  }

  GestureDetector _buildButtonColumn(
      Color color, IconData icon, String label, dynamic doAction) {
    return GestureDetector(
        onTap: () {
          if (null != doAction) {
            doAction();
          }
        },
        child: Column(
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
                )),
          ],
        ));
  }

  dynamic share() async {
    final RenderBox box = context.findRenderObject();
    var address = DotEnv().env['FATAPP_ADDRESS'];
    var date  = DateFormat("dd/MM 'às' HH:mm").format(widget.activity.
      initialDate.
      toLocal()
    );

    Share.share('Venha participar da atividade "${widget.activity.title}", que ocorrerá dia $date na $address',
      subject: widget.activity.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  dynamic subscribe() async {
    var data = jsonEncode({"userId": widget.user.id});
    await ActivityController()
        .subscribe(widget.activity, data, widget.user.token);
    Fluttertoast.showToast(
        msg: "Inscrição realizada com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {
      subscribed = true;
    });
  }

  dynamic cancelSubscription() async {
    var data = jsonEncode({"userId": widget.user.id});
    await ActivityController()
        .cancelSubscription(widget.activity, data, widget.user.token);
    Fluttertoast.showToast(
        msg: "Inscrição cancelada com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {
      subscribed = false;
    });
  }
}
