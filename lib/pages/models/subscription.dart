class Subscription {
  int id;
  int attended;
  int activityId;
  int studentId;
  
  Subscription.fromJson(jsonToParse) {
    json = json.decode(jsonToParse)
    id = json['id'];
    attended = json['attended'];
    activityId = json['activity_id'];
    studentId = json['student_id'];
  }
}