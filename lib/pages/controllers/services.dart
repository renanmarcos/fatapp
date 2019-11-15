import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Services {
  static final baseUri = DotEnv().env['FATAPP_API'];

  getAllData(resource, token) async {
    var response;
    try {
      response = await http.Client().get(baseUri + resource, headers: {
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

  getData(resource, id, token) async {
    var response;
    try {
      response = await http.Client()
          .get(baseUri + resource + '/' + id.toString(), headers: {
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

  postData(resource, dataToPost, token) async {
    var response;
    try {
      response = await http.Client().post(Uri.encodeFull(baseUri + resource),
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

  putData(resource, id, dataToPut, token, [args = ""]) async {
    var response;
    try {
      response = await http.Client().put(
          baseUri + resource + '/' + id.toString() + args,
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
