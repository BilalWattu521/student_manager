import 'package:class_12/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentManager {
  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<List<Student>> getAllStudents() async {
    final prefs = await _prefs;
    List<Student> studentList = [];
    var keys = prefs.getKeys();

    for (var key in keys) {
      if (key.startsWith('student_')) { 
        var studentRecord = prefs.getString(key);
        if (studentRecord != null && studentRecord.isNotEmpty) {
          try {
            Student student = Student.fromJsonString(studentRecord);
            studentList.add(student);
          } catch (e) {
            print("Error parsing student data for key $key: $e");
          }
        }
      }
    }
    return studentList;
  }

  static Future<void> addStudent(Student student) async {
    final prefs = await _prefs;
    await prefs.setString('student_${student.id}', student.toJsonString());
  }

  static Future<void> updateStudent(Student student) async {
    final prefs = await _prefs;
    await prefs.setString('student_${student.id}', student.toJsonString());
  }

  static Future<void> removeStudent(String id) async {
    final prefs = await _prefs;
    await prefs.remove('student_$id');
  }
}