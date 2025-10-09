import 'package:flutter/material.dart';

enum Department{finance, law, it, medical,work}

enum Gender{male, female}

final Map<Department, IconData> workicon = {
  Department.finance : Icons.attach_money,
  Department.law : Icons.gavel,
  Department.it : Icons.computer,
  Department.medical : Icons.local_hospital,
  Department.work : Icons.build,
}; 

class Students {
  final String FirstName;
  final String LastName;
  final Department department;
  final int grade;
  final Gender gender;

  Students({
    required this.FirstName,
    required this.LastName,
    required this.department,
    required  this.gender,
    required this.grade,
  });

}