class Resource {
  int id;
  String name;
  
  Resource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}