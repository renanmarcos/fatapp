class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  String token;

  User({this.token, this.id, this.name, this.email, this.cpf, this.password});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    cpf = json['user']['cpf'];
    password = json['user']['password'];
  }
  User.token(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }
}