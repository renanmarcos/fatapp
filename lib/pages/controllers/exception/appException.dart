class AppException implements Exception {
  final _message;
  final _prefix;
  
AppException([this._message, this._prefix]);
  
String toString() {
    return "$_prefix$_message";
  }
}

class InternException extends AppException {
  InternException() : super("", "Erro interno");
}

class LoginException extends AppException {
  LoginException() : super("", "Cadastro inválido");
}


class ValidateException extends AppException {
  ValidateException([message]) : super(message);
}
