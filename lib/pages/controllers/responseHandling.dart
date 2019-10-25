import 'dart:convert';
import 'package:fatapp/pages/controllers/exception/appException.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

class ResponseHandling extends AppException {
  
  handling(http.Response response) {
    var responseJson = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return responseJson;
    }
    else if (response.statusCode == 400) {
      validateCPF(responseJson);
    }
    else {
      throw InternException();
    }
  }
  validateEmail(String string) {
    if (!isEmail(string)) {
      throw ValidateException("Email inválido");
    }
  }
  validateCPF(dynamic body) {
    if (body.toString() == "CPF Já Existe") {
      throw ValidateException(body.toString());
    } else {
      throw LoginException();
    }
  }
}