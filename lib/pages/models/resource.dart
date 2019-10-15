class Resource {
  int id;
  String name;
  
  Resource.fromJson(jsonToParse) {
    json = json.decode(jsonToParse)
    id = json['id'];
    name = json['name'];
  }
}