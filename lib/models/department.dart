import 'package:flutter/material.dart';

class Department {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  const Department({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}
final List<Department> availableDepartments = [
  Department(
    id: 'd1',
    name: 'Computer Engineering',
    color: Colors.blue,
    icon: Icons.computer,
  ),
  Department(
    id: 'd2',
    name: 'Computer Science',
    color: Colors.teal,
    icon: Icons.science,
  ),
  Department(
    id: 'd3',
    name: 'Cybersecurity',
    color: Colors.deepPurple,
    icon: Icons.security,
  ),
  Department(
    id: 'd4',
    name: 'Artificial Intelligence',
    color: Colors.purple,
    icon: Icons.smart_toy,
  ),
];