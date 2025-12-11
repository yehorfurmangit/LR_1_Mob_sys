import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import '../models/student.dart';
import '../models/department.dart'; 

class StudentItem extends StatelessWidget {
  final Students student;
  final Function()? onTap;

  const StudentItem({
    super.key,
    required this.student,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final department = availableDepartments.firstWhere(
      (dept) => dept.id == student.departmentId,
      orElse: () => availableDepartments[0],
    );

    final Color bgColor =
        student.gender == Gender.male ? Colors.blue[100]! : Colors.pink[100]!;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.black12,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${student.firstName} ${student.lastName}',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Оцінка: ${student.grade}',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Icon(
              department.icon, 
              size: 30,
              color: department.color, 
            ),
          ],
        ),
      ),
    );
  }
}