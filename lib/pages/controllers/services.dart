import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Services {
  getAllData(url, token) async {
    try {
      final response = await http.Client().get(
        DotEnv().env['FATAPP_API'] + url,      
        headers: 
        {
          "Content-Type": "application/json",
          "Accept": "application/json",
          //"token": token
        }
      );
      return ResponseHandling().handling(response);
    } catch(e)  {
      Fluttertoast.showToast(
        msg: "Não há conexão com o servidor",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }
  getData(url, id, token) async {
    try {
      final response = await http.Client().get(
        DotEnv().env['FATAPP_API'] + url + '/' + id.toString(), 
        headers: 
        {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "token": token
        }
      );
      return ResponseHandling().handling(response);
    } catch(e)  {
      Fluttertoast.showToast(
        msg: "Não há conexão com o servidor",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }
  postData(url, dataToPost, token) async {
    try {
      final response = await http.Client().post(
        Uri.encodeFull(DotEnv().env['FATAPP_API'] + url),  
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "token": token
        },
        body: dataToPost
      );
      return ResponseHandling().handling(response);
    } catch(e)  {
      Fluttertoast.showToast(
        msg: "Não há conexão com o servidor",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }

  putData(url, id, dataToPut, token) async {
    try {
      final response = await http.Client().put(
        DotEnv().env['FATAPP_API'] + url + '/' + id.toString(),  
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "token": token
        },
        body: dataToPut
      );
      return ResponseHandling().handling(response);
    } catch(e)  {
      Fluttertoast.showToast(
        msg: "Não há conexão com o servidor",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
       timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }
  }
}