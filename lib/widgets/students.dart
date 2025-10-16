import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {

  final List<Students> students = [
  Students(
    FirstName : 'Олексій',
    LastName: 'Сідоренко',
    department: Department.law,
    grade: 100,
    gender: Gender.male
  ),
      Students(
    FirstName : 'Інна',
    LastName: 'Павлюченко',
    department: Department.medical,
    grade: 66,
    gender: Gender.female
  ),
  Students(
    FirstName : 'Єгор',
    LastName: 'Фурман',
    department: Department.it,
    grade: 78,
    gender: Gender.male
  ),
  Students(
    FirstName : 'Юля',
    LastName: 'Лукіна',
    department: Department.work,
    grade: 55,
    gender: Gender.female
  ),
  Students(
    FirstName : 'Валентина',
    LastName: 'Йосип',
    department: Department.finance,
    grade: 88,
    gender: Gender.female
  ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
