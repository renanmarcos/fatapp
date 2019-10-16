import 'dart:convert';

class Resource {
  int id;
  String name;
  
  Resource({this.id, this.name});
  
  Resource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  List<Resource> resourceList(String body) {
    final list = json.decode(body).cast<Map<String, dynamic>>();
    return list.map<Resource>((json) => Resource.fromJson(json)).toList();
  }
}