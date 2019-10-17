
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'appException.dart';
import 'dart:async';

class Services {
  Future<String> getAllData(url, token) async{
    final response = await http.Client().get(
      DotEnv().env['FATAPP_API'] + url,      
      headers: 
      {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: token
      }
    );
    return _response(response);
  }
  Future<String> getData(url, id, token) async{
    final response = await http.Client().get(
      DotEnv().env['FATAPP_API'] + url + '/' + id, 
      headers: 
      {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: token
      }
    );
    return _response(response);
  }
  Future<String> postData(url, dataToPost, token) async{
    final response = await http.Client().post(
      Uri.encodeFull(DotEnv().env['FATAPP_API'] + url),  
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: dataToPost
    );
    return _response(response);
  }

  Future<String> putData(url, id, dataToPut, token) async{
    final response = await http.Client().put(
      DotEnv().env['FATAPP_API'] + url + '/' + id,  
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: token
      },
      body: dataToPut

    );
    return _response(response);
  }
  dynamic _response(http.Response response) 
  {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 422:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(response.statusCode.toString());
    }
  }
}