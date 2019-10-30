class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  String token;

  User({this.token, this.id, this.name, this.email, this.cpf, this.password});

  User.create(Map<String, dynamic> json) {
    this.token = json['token'];
    this.id = json['user']['id'];
    this.name = json['user']['name'];
    this.email = json['user']['email'];
    this.cpf = json['user']['cpf'];
    this.password = json['user']['password'];
  }

  User.fromJson(Map<String, dynamic> json, String token) {
    this.token = token;
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.cpf = json['cpf'];
    this.password = json['password'];
  }

  User.token(Map<String, dynamic> json) {
    this.id = json['id'];
    this.token = json['token'];
  }
}
