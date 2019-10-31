import 'dart:convert';

class Subscription {
  int id;
  int attended;
  int activityId;
  int studentId;

  Subscription({this.id, this.attended, this.activityId, this.studentId});

  Subscription.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.attended = json['attended'];
    this.activityId = json['activity_id'];
    this.studentId = json['student_id'];
  }

  List<Subscription> subscriptionList(String body) {
    return json
        .decode(body)
        .map((data) => Subscription.fromJson(data))
        .toList();
  }
}
