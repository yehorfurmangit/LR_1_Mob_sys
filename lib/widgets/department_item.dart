import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/department.dart';

class DepartmentItem extends StatelessWidget {
  final Department department;
  final int numberOfStudents;

  const DepartmentItem({
    super.key,
    required this.department,
    required this.numberOfStudents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            department.color,
            department.color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            department.name,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Students enrolled: $numberOfStudents',
            style: GoogleFonts.lato(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const Spacer(), 
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              department.icon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}