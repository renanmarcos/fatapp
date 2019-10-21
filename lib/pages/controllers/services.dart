
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'appException.dart';
import 'dart:async';

class Services {
  Future<Map<String, dynamic>> getAllData(url, token) async {
    final response = await http.Client().get(
      DotEnv().env['FATAPP_API'] + url,      
      headers: 
      {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token": token
      }
    );
    return _response(response);
  }
  Future<Map<String, dynamic>> getData(url, id, token) async {
    final response = await http.Client().get(
      DotEnv().env['FATAPP_API'] + url + '/' + id.toString(), 
      headers: 
      {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token": token
      }
    );
    return _response(response);
  }
  Future<Map<String, dynamic>> postData(url, dataToPost, token) async {
    final response = await http.Client().post(
      Uri.encodeFull(DotEnv().env['FATAPP_API'] + url),  
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "token": token
      },
      body: dataToPost
    );
    print(response.statusCode);
    return _response(response);
  }

  Future<Map<String, dynamic>> putData(url, id, dataToPut, token) async {
    final response = await http.Client().put(
      DotEnv().env['FATAPP_API'] + url + '/' + id.toString(),  
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
    }
  }
}