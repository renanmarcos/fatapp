import 'dart:convert';

import 'package:fatapp/pages/controllers/appException.dart';
import 'package:http/http.dart' as http;

class ExceptionHandling extends AppException {
  
  Map<String, dynamic> responseException(http.Response response) 
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