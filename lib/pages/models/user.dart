class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  
  User.fromJson(jsonToParse) {
    json = json.decode(jsonToParse)
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    password = json['password'];
  }
}