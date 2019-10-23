
import 'dart:convert';
import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
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
    return ResponseHandling().handling(response);
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
    return ResponseHandling().handling(response);
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
    return ResponseHandling().handling(response);
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
    return ResponseHandling().handling(response);
  }
}