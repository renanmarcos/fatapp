
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'appException.dart';
import 'dart:async';

class AbstractController {
  Future<String> getData(url) async{
    var response = await http.get(
      DotEnv().env['FATAPP_API'] + url,      
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
      DotEnv().env['FATAPP_API'] + url,  
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
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}