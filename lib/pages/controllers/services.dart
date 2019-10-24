
import 'package:fatapp/pages/controllers/responseHandling.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Services {
  getAllData(url, token) async {
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
  getData(url, id, token) async {
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
  postData(url, dataToPost, token) async {
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

  putData(url, id, dataToPut, token) async {
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