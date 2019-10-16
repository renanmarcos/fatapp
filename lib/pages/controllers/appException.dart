class AppException implements Exception {
  final _message;
  final _prefix;
  
AppException([this._message, this._prefix]);
  
String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message]): super(message, "Erro durante comunicação com o servidor: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Erros de validação: ");
}
