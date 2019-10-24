import 'package:fatapp/pages/models/course.dart';
import 'services.dart';

class CourseController {
  Future<List<Course>> getCourses() async {
    final response = await Services().getAllData('courses', null);
    final items = (response as List).map((i) => new Course.fromJson(i));
    return items;
  }
}