import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Services {
  getAllData(url, token) async {
    var response;
    try {
      response = await http.Client().get(DotEnv().env['FATAPP_API'] + url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": token
          });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Não há conexão com o servidor",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return ResponseHandling().handling(response);
  }

  getData(url, id, token) async {
    var response;
    try {
      response = await http.Client().get(
          DotEnv().env['FATAPP_API'] + url + '/' + id.toString(),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": token
          });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Não há conexão com o servidor",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return ResponseHandling().handling(response);
  }

  postData(url, dataToPost, token) async {
    var response;
    try {
      response = await http.Client().post(
          Uri.encodeFull(DotEnv().env['FATAPP_API'] + url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": token
          },
          body: dataToPost);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Não há conexão com o servidor",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return ResponseHandling().handling(response);
  }

  putData(url, id, dataToPut, token, [complementation = ""]) async {
    var response;
    try {
      response = await http.Client().put(
          DotEnv().env['FATAPP_API'] +
              url +
              '/' +
              id.toString() +
              complementation,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": token
          },
          body: dataToPut);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Não há conexão com o servidor",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
    return ResponseHandling().handling(response);
  }
}
