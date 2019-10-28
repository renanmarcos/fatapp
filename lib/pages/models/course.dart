class Course {
  int id;
  String name;
  String acronym;
  
  Course({this.id, this.name, this.acronym});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    acronym = json['acronym'];
  }
}