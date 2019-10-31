import 'dart:convert';
import 'package:fatapp/pages/controllers/exception/appException.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:validators/validators.dart';

class ResponseHandling extends AppException {
  handling(Response response) {
    var responseJson = json.decode(response.body);

    if (response.statusCode == 204) {
      return true;
    }

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return responseJson;
    }

    if (response.statusCode == 400) {
      validateCPF(response.body);
    }

    if (response.statusCode == 401 || response.statusCode == 404) {
      throw LoginException();
    }

    throw InternalException();
  }

  void validateEmail(String string) {
    if (!isEmail(string)) {
      Fluttertoast.showToast(
          msg: "Email Inválido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void validatePassword(String string) {
    if (string.length < 6) {
      Fluttertoast.showToast(
          msg: "Senha Inválida",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void validateCPF(body) {
    if (body.toString().compareTo("CPF Já Existe") == 0) {
      throw ValidationException("CPF Já Existe");
    }

    throw InternalException();
  }
}
