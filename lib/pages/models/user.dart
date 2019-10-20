class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  String token;

  User({this.id, this.name, this.email, this.cpf, this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    password = json['password'];
  }
  User.token(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }
}