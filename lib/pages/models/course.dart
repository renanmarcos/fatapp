class Course {
  int id;
  String name;
  String acronym;

  Course({this.id, this.name, this.acronym});

  Course.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.acronym = json['acronym'];
  }
}
