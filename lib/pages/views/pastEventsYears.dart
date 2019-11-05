// import 'package:flutter/material.dart';

// class PastEventsYears extends StatelessWidget {
//   const PastEventsYears({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final events = ['Fatecnologia 2018', 'Fatecnologia 2017', 'Fatecnologia 2016', 'Fatecnologia 2015'];
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red,
//           title: const Text('Filtre pelo ano',
//               style: TextStyle(fontFamily: 'Noto')),
//         ),
//         body: new ListView.builder(
//           itemCount: events.length,
//           itemBuilder: (context, index) {
//             return Card(
//               elevation: 2.0,
//               margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
//               child: InkWell(
//                 splashColor: Colors.blue.withAlpha(30),
//                 onTap: () {
//                   // pastEventsYears();
//                 },
//                 child: ListTile(
//                   title: Text(events[index],
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Raleway',
//                           fontSize: 18.0)),
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }
