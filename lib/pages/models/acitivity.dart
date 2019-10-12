class Activity {
  int id;
  String title;
  DateTime startAt;
  String speaker;
  String description;
  
  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startAt = json['start_at'];
    speaker = json['speaker'];
    description = json['description'];
  }
}