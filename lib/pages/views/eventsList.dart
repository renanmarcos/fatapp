import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

class EventsList extends StatefulWidget {
  @override 
  _EventsListState createState() => new _EventsListState();
}

class _EventsListState extends State<EventsList> {
  Widget _appBarTitle = new Text('Search...');
  Icon _searchIcon = new Icon(Icons.search);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(6.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(19.0, 6.0, 19.0, 6.0),
                            child: myDetailsContainer1(),
                          ),
                        ),
                        FlatButton(
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(10.0),
                          
                          splashColor: Colors.redAccent,
                          onPressed: () {
                          /*...*/
                          },
                          child: Text(
                          
                          "Inscrever-se",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800,    
                          
                          fontFamily: 'Raleway',) ,
                          ),
                        ),
                      ],)
                ),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            // child: myDetailsContainer2(),
                          ),
                        ),
                      ],)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(9.0, 3.0, 9.0, 7.0),
          child: Container(child: Text("BigData", textAlign: TextAlign.left,
            style: TextStyle(color: Color(0xffe6020a), fontSize: 18.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
        ),
        Container(
          child: new ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 200.0,
              
            ),
          child: Text("Essa paletra é super foda sim isso tem que ser maior o texto tem que ser super frande pra testar Essa paletra é super foda Essa paletra é super foda Essa paletra é super foda Essa paletra é super foda Essa paletra é super foda",
          style: TextStyle(height: 1.5, color: Colors.black54, fontSize: 12.0,fontWeight: FontWeight.bold),)
          ),
        ),
      ],
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Chocolate Haven",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Row(children: <Widget>[
            Container(child: Text("4.3",
              style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStarHalf, color: Colors.amber,
              size: 15.0,),),
            Container(child: Text("(75) \u00B7 1.2 mi",
              style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
          ],)),
        ),
        Container(child: Text("Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Cake Walk",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Row(children: <Widget>[
            Container(child: Text("4.0",
              style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Text("(100) \u00B7 2.0 mi",
              style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
          ],)),
        ),
        Container(child: Text("Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
      ],
    );
  }

  Widget myDetailsContainer4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("Chocolate Bar",
            style: TextStyle(color: Color(0xffe6020a), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Row(children: <Widget>[
            Container(child: Text("3.5", style: TextStyle(
              color: Colors.black54, fontSize: 18.0,),)),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStar, color: Colors.amber, size: 15.0,),),
            Container(child: Icon(
              FontAwesomeIcons.solidStarHalf, color: Colors.amber,
              size: 15.0,),),
            Container(child: Text("(50) \u00B7 2.5 mi",
              style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
          ],)),
        ),
        Container(child: Text("Pastries \u00B7 Phoenix,AZ",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
      ],
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
      }
    });
  }
}