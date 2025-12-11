import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  final List<Students> students;
  final Function(Students) onRemove;
  final Function(Students) onEdit;

  const StudentsScreen({
    super.key,
    required this.students,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Dismissible(
          key: ValueKey(student.firstName + student.lastName + student.departmentId),
          onDismissed: (direction) {
            onRemove(student);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          child: StudentItem(
            student: student,
            onTap: () {
              onEdit(student);
            },
          ),
        );
      },
    );
  }
}