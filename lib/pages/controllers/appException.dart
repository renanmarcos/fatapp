class AppException implements Exception {
  final _message;
  final _prefix;
  
AppException([this._message, this._prefix]);
  
String toString() {
    return "$_prefix$_message";
  }
}

class BadRequestException extends AppException {
  BadRequestException() : super("", "Erro interno");
}

class NotFoundException extends AppException {
  NotFoundException() : super("", "Cadastro inválido");
}

class UnprocessableException extends AppException {
  UnprocessableException([message]) : super("Erros de validação: \n", message);
}
