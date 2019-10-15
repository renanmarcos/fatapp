class Student {
  int id;
  int ra;
  String course;
  
  Student.fromJson(jsonToParse) {
    json = json.decode(jsonToParse)
    id = json['id'];
    ra = json['ra'];
    course = json['course'];
  }
}