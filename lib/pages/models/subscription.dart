class Subscription {
  int id;
  int attended;
  int activityId;
  int studentId;
  
  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attended = json['attended'];
    activityId = json['activity_id'];
    studentId = json['student_id'];
  }
}