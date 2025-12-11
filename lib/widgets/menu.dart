import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/student.dart';
import 'departments_window.dart'; 
import 'students.dart';
import 'add_student.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; 

  final List<Students> _students = [
    Students(
      firstName: 'Олексій',
      lastName: 'Сідоренко',
      departmentId: 'd1',
      grade: 100,
      gender: Gender.male
    ),
    Students(
      firstName: 'Інна',
      lastName: 'Павлюченко',
      departmentId: 'd2',
      grade: 66,
      gender: Gender.female
    ),
    Students(
      firstName: 'Єгор',
      lastName: 'Фурман',
      departmentId: 'd3',
      grade: 78,
      gender: Gender.male
    ),
    Students(
      firstName: 'Юля',
      lastName: 'Лукіна',
      departmentId: 'd4',
      grade: 55,
      gender: Gender.female
    ),
  ];

  void _addNewStudent(Students student) {
    setState(() {
      _students.add(student);
    });
  }

  void _removeStudent(Students student) {
    final studentIndex = _students.indexOf(student);
    setState(() {
      _students.remove(student);
    });
    
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Студента видалено'),
        action: SnackBarAction(
          label: 'ВІДМІНИТИ',
          onPressed: () {
            setState(() {
              _students.insert(studentIndex, student);
            });
          },
        ),
      ),
    );
  }

  void _updateStudent(Students originalStudent, Students updatedStudent) {
    final index = _students.indexOf(originalStudent);
    if (index != -1) {
      setState(() {
        _students[index] = updatedStudent;
      });
    }
  }

  void _openAddModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return OknoNewStudent(onAddStudent: _addNewStudent);
      }
    );
  }
  
  void _openEditModal(Students student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return OknoNewStudent(
          studentToEdit: student,
          onAddStudent: (updatedStudent) {
            _updateStudent(student, updatedStudent);
          }
        );
      }
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage;
    String activePageTitle;

    if (_selectedPageIndex == 0) {
      activePage = DepartmentsScreen(students: _students);
      activePageTitle = 'Departments';
    } else {

      activePage = StudentsScreen(
        students: _students,
        onRemove: _removeStudent,
        onEdit: _openEditModal,
      );
      activePageTitle = 'Students';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (_selectedPageIndex == 1)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _openAddModal,
            ),
        ],
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Departments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Students',
          ),
        ],
      ),
    );
  }
}