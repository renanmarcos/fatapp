import 'package:fatapp/pages/models/course.dart';
import 'services.dart';

class CourseController {
  Future<List<Course>> getCourses() async {
    final response = await Services().getAllData('courses', null);
    List<Course> allCourses = [];
    for (var json in response) {
      allCourses.add(Course.fromJson(json));
    }
    return allCourses;
  }
}