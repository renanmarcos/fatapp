class Token {
  int id;
  String token;

  Token({this.id, this.token});

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }
}