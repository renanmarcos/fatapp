import 'dart:convert';
import 'package:fatapp/pages/controllers/exception/appException.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

class ResponseHandling extends AppException {
  
  handling(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      if(response.statusCode == 204) {
        return true;
      }
      return json.decode(response.body);
    }
    else if (response.statusCode == 400) {
      validateCPF(response.body);
    }
    else if (response.statusCode == 401 || response.statusCode == 404) {
      throw LoginException();
    }
    else {
      throw InternException();
    }
  }
  validateEmail(String string) {
    if (!isEmail(string)) {
      Fluttertoast.showToast(
        msg: "Email Inválido",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }
  validatePassword(String string) {
    if(string.length < 6) {
      Fluttertoast.showToast(
        msg: "Senha Inválida",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  validateCPF(body) {
    if (body.toString().compareTo("CPF Já Existe") == 0) {
      throw ValidateException("CPF Já Existe");
    } else {
      throw InternException();
    }
  }
}