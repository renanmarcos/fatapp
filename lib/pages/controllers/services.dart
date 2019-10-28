import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Services {
  getAllData(url, token) async {
    var response;
    try {
      response = await http.Client().get(
        DotEnv().env['FATAPP_API'] + url,      
        headers: 
        {
          "Content-Type": "application/json",
          "Accept": "application/json",
          //"token": token
        }
      );
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
    return ResponseHandling().handling(response);
  }
  getData(url, id, token) async {
    var response;
    try {
        response = await http.Client().get(
        DotEnv().env['FATAPP_API'] + url + '/' + id.toString(), 
        headers: 
        {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "token": token
        }
      );
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
          //"token": token
        },
        body: dataToPost
      );
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
    return ResponseHandling().handling(response);
  }



  Future<Map<String, dynamic>> putDataAttendee(id, dataToPut, token) async {
    final response = await http.Client().put(
      DotEnv().env['FATAPP_API'] + "activities" + '/' + id.toString() + "/attendee",  
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token": token
      },
      body: dataToPut

    );
    return _response(response);
  }


  Map<String, dynamic> _response(http.Response response) 
  {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        throw UnprocessableException(response.body.toString());
      case 401:
        throw NotFoundException();
      case 404:
        throw NotFoundException();
      default:
        throw BadRequestException();
        
  putData(url, id, dataToPut, token) async {
    var response;
    try {
      response = await http.Client().put(
        DotEnv().env['FATAPP_API'] + url + '/' + id.toString(),  
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "token": token
        },
        body: dataToPut
      );
    } catch(e)  {
      Fluttertoast.showToast(
        msg: "Não há conexão com o servidor",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
       timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
    }
    return ResponseHandling().handling(response);
  }
}