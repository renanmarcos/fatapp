import 'package:fatapp/pages/models/acitivity.dart';

class Subscription {
  int id;
  bool attended;
  Activity activity;

  Subscription({this.id, this.attended, this.activity});

  Subscription.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.attended = json['attended'];
    this.activity = Activity.fromJson(json['activity']);
  }

  List<Subscription> fromJsonList(List json) {
    return json.map((data) => Subscription.fromJson(data)).toList();
  }
}
