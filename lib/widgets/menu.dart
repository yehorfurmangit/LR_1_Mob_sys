import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
  
  List<Students> _students = [];
  
  bool _isLoading = true;
  
  String? _error;

  final Uri _databaseUrl = Uri.parse(
      'https://studentlr4-default-rtdb.firebaseio.com/students.json');

  @override
  void initState() {
    super.initState();
    _loadStudents(); 
  }

  Future<void> _loadStudents() async {
    try {
      final response = await http.get(_databaseUrl);

      if (response.statusCode == 200) {
        if (response.body == 'null') {
          setState(() {
            _students = [];
            _isLoading = false;
          });
          return;
        }

        final Map<String, dynamic> listData = json.decode(response.body);
        final List<Students> loadedStudents = [];

        listData.forEach((id, data) {
          loadedStudents.add(Students.fromJson(data, id));
        });

        setState(() {
          _students = loadedStudents;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      setState(() {
        _error = 'Не вдалося завантажити дані. Перевірте інтернет.';
        _isLoading = false;
      });
    }
  }

  Future<void> _addNewStudent(Students student) async {
    setState(() {
      _isLoading = true; 
    });

    try {
      final response = await http.post(
        _databaseUrl,
        body: json.encode(student.toJson()),
      );

      final newId = json.decode(response.body)['name'];

      final newStudent = Students(
        id: newId,
        firstName: student.firstName,
        lastName: student.lastName,
        departmentId: student.departmentId,
        grade: student.grade,
        gender: student.gender,
      );

      setState(() {
        _students.add(newStudent);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = "Помилка додавання";
        _isLoading = false;
      });
    }
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
    ).closed.then((reason) async {
      if (reason != SnackBarClosedReason.action) {
        final url = Uri.parse(
            'https://studentlr4-default-rtdb.firebaseio.com/students/${student.id}.json');
        
        try {
          await http.delete(url);
        } catch (error) {
          setState(() {
            _students.insert(studentIndex, student); 
          });
        }
      }
    });
  }

  Future<void> _updateStudent(Students original, Students updated) async {
    final index = _students.indexOf(original);
    
    setState(() {
      _students[index] = updated;
      _isLoading = true;
    });

    final url = Uri.parse(
        'https://studentlr4-default-rtdb.firebaseio.com/students/${original.id}.json');

    try {
      await http.patch(url, body: json.encode(updated.toJson()));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
       setState(() {
        _isLoading = false;
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
            final studentWithId = Students(
               id: student.id, 
               firstName: updatedStudent.firstName,
               lastName: updatedStudent.lastName,
               departmentId: updatedStudent.departmentId,
               gender: updatedStudent.gender,
               grade: updatedStudent.grade
            );
            _updateStudent(student, studentWithId);
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

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (_error != null) {
       return Scaffold(
        body: Center(child: Text(_error!)),
      );
    }

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