import 'dart:convert';
import 'package:fatapp/pages/controllers/exception/appException.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:validators/validators.dart';

class ResponseHandling extends AppException {
  handling(Response response) {
    if (response.statusCode == 204) {
      return true;
    }

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return json.decode(response.body);
    }

    if (response.statusCode == 422) {
      handleUnprocessableEntityException(response.body);
    }

    if (response.statusCode == 401 || response.statusCode == 404) {
      throw LoginException();
    }

    throw InternalException();
  }

  bool validateEmail(String string) {
    if (string.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email precisa ser preenchido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    if (!isEmail(string)) {
      Fluttertoast.showToast(
          msg: "Email Inválido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }

  bool validatePassword(String string) {
    if (string.isEmpty) {
      Fluttertoast.showToast(
          msg: "Senha precisa ser preenchida",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    if (string.length < 6) {
      Fluttertoast.showToast(
          msg: "Senha Inválida",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }

  bool validateRA(String string) {
    if (string.isEmpty) {
      Fluttertoast.showToast(
          msg: "RA precisa ser preenchido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    if (string.length < 13) {
      Fluttertoast.showToast(
          msg: "RA Inválido",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }

  void handleUnprocessableEntityException(body) {
    var exception = json.decode(body);
    throw ValidationException(exception['message']);
  }
}
