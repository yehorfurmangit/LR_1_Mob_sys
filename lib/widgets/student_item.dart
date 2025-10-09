import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Students student;

  const StudentItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    // Колір айтему залежно від статі
    final Color bgColor =
        student.gender == Gender.male ? Colors.blue[100]! : Colors.pink[100]!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ім’я та прізвище
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${student.FirstName} ${student.LastName}',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('Оцінка: ${student.grade}'),
            ],
          ),
          // Іконка кафедри
          Icon(
             workicon[student.department],
            size: 30,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
