
import 'package:http/http.dart' as http;
import 'dart:async';

class Services {

  Future<String> getData(url) async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"

      }
    );
    int statusCode = response.statusCode;

    if(statusCode == 200){
      return response.body;

    }
    else{
      return null;
    }
  }

  Future<String> postData(url,dataToPost) async{
    var response = await http.post(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"

      },
      body: dataToPost

    );

    int statusCode = response.statusCode;

    if(statusCode == 201){
      return response.body;

    }
    else{
      return null;
    }

    
  }

  Future<String> putData(url,id,dataToPut) async{
    var response = await http.post(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"

      },
      body: dataToPut

    );
    int statusCode = response.statusCode;
    
    if(statusCode == 200){
      return response.body;

    }
    else{
      return null;
    }
  }
}