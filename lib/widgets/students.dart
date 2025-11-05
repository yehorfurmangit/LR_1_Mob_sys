import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';
import 'add_student.dart'; 

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override 
  State < StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final List<Students> _students = [
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
  void _addNewStudent(Students student) {
    setState(() {
      _students.add(student);
    });
  }
  void _openAddModal(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_){
        return OknoNewStudent(onAddStudent: _addNewStudent,);
      }
    );
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
            _insertStudent(studentIndex, student);
          },
        ),
      ),
    );
  }
void _insertStudent(int index, Students student) {
    setState(() {
      _students.insert(index, student); 
    });
  }
  void _updateStudent(Students originalStudent, Students updatedStudent) {
    final index = _students.indexOf(originalStudent);
    if (index != -1) {
      setState(() {
        _students[index] = updatedStudent;
      });
    }
  }

  void _openEditModal(Students studentToEdit){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_){
        return OknoNewStudent(
          studentToEdit: studentToEdit, 
          onAddStudent: (Students updatedStudent) {
            _updateStudent(studentToEdit, updatedStudent);
          },
        );
      }
    );
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddModal, 
          ),
        ],
      ),
body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          
          final student = _students[index];

          return Dismissible(

            key: ValueKey(student.FirstName + student.LastName), 
            
            onDismissed: (direction) {
              _removeStudent(student);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ),
            child: StudentItem(
              student: student,
              onTap: () {
                _openEditModal(student);
              },
            ),

          ); 
        },
      ),
    );
  }
}
