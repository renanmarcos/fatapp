
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'appException.dart';
import 'dart:async';

class Services {
  Future<String> getAllData(url) async{
    var response = await http.get(
      DotEnv().env['FATAPP_API'] + url,      
      headers: 
      {
        "Content-Type": "application/json"
      }
    );
    return messageResponse(response);
  }
  Future<String> getData(url, id) async{
    var response = await http.get(
      DotEnv().env['FATAPP_API'] + url + '/' + id, 
      headers: 
      {
        "Content-Type": "application/json"
      }
    );
    return messageResponse(response);
  }
  Future<String> postData(url,dataToPost) async{
    var response = await http.post(
      DotEnv().env['FATAPP_API'] + url,  
      headers: {
        "Content-Type": "application/json"
      },
      body: dataToPost
    );

    return messageResponse(response);
  }

  Future<String> putData(url,id,dataToPut) async{
    var response = await http.put(
      DotEnv().env['FATAPP_API'] + url + '/' + id,  
      headers: {
        "Content-Type": "application/json"
      },
      body: dataToPut

    );
    return messageResponse(response);
  }
  dynamic messageResponse(http.Response response) 
  {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
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