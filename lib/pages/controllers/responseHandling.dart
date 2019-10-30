import 'dart:convert';
import 'package:fatapp/pages/controllers/exception/appException.dart';
import 'package:http/http.dart';
import 'package:validators/validators.dart';

class ResponseHandling extends AppException {
  void handling(Response response) {
    var responseJson = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return responseJson;
    }

    if (response.statusCode == 400) {
      validateCPF(responseJson);
    }

    if (response.statusCode == 401) {
      throw LoginException();
    }

    throw InternalException();
  }

  void validateEmail(String string) {
    if (!isEmail(string)) {
      throw ValidationException("Email inválido");
    }
  }

  void validatePassword(String string) {
    if (string.length < 6) {
      throw ValidationException("Senha inválida");
    }
  }

  void validateCPF(body) {
    if (body.toString() == "CPF Já Existe") {
      throw ValidationException(body.toString());
    }

    throw InternalException();
  }
}
