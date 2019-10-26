class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  String token;

  User({this.token, this.id, this.name, this.email, this.cpf, this.password});

  User.create(Map<String, dynamic> json) {
    token = json['token'];
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    cpf = json['user']['cpf'];
    password = json['user']['password'];
  }
  User.fromJson(Map<String, dynamic> json, String token) {
    token = token;
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