import 'dart:convert';

class Subscription {
  int id;
  int attended;
  int activityId;
  int studentId;
  
  Subscription({this.id, this.attended, this.activityId, this.studentId});

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attended = json['attended'];
    activityId = json['activity_id'];
    studentId = json['student_id'];
  }
  List<Subscription> subscriptionList(String body) {
    final list = json.decode(body)
      .map((data) =>Subscription.fromJson(data))
      .toList();
    return list;
  }
}