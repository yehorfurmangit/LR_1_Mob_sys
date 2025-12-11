import 'package:flutter/material.dart';
import '../models/department.dart';
import '../models/student.dart';
import 'department_item.dart'; 

class DepartmentsScreen extends StatelessWidget {
  final List<Students> students;

  const DepartmentsScreen({
    super.key, 
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        itemCount: availableDepartments.length,
        itemBuilder: (context, index) {
          final dept = availableDepartments[index];
          
          final studentCount = students
              .where((s) => s.departmentId == dept.id)
              .length;

          return DepartmentItem(
            department: dept,
            numberOfStudents: studentCount,
          );
        },
      ),
    );
  }
}