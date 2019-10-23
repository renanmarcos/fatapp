import 'services.dart';
import 'dart:async';

class CourseController {
  Future<Map<String, dynamic>> show(token) async {
    final response = await Services().getAllData('courses', token);
    return response; 
  }
}