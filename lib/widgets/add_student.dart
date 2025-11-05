import 'package:flutter/material.dart';
import '../models/student.dart';

class OknoNewStudent extends StatefulWidget {
  final Function(Students) onAddStudent;
  final Students? studentToEdit;

  const OknoNewStudent({
    super.key, 
    required this.onAddStudent, 
    this.studentToEdit,
  });

  @override
  State<OknoNewStudent> createState() => _OknoNewStudentState();
}

class _OknoNewStudentState extends State<OknoNewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gradeController = TextEditingController();

  Department _selectedDepartment = Department.finance;
  Gender _selectedGender = Gender.male; 
  
@override
  void initState() {
    super.initState();
    if (widget.studentToEdit != null) {
      _firstNameController.text = widget.studentToEdit!.FirstName;
      _lastNameController.text = widget.studentToEdit!.LastName;
      _gradeController.text = widget.studentToEdit!.grade.toString();
      _selectedDepartment = widget.studentToEdit!.department;
      _selectedGender = widget.studentToEdit!.gender;
    }
  }

  void _submitData() {
    final enteredFirstName = _firstNameController.text;
    final enteredLastName = _lastNameController.text;
    final enteredGrade = int.tryParse(_gradeController.text) ?? 0;

    if (enteredFirstName.isEmpty ||
        enteredLastName.isEmpty ||
        enteredGrade <= 0 ||
        enteredGrade > 100) {
      return;
    }

    widget.onAddStudent(
      Students(
        FirstName: enteredFirstName,
        LastName: enteredLastName,
        department: _selectedDepartment,
        grade: enteredGrade,
        gender: _selectedGender, 
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.studentToEdit != null;
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isEditing ? 'Редагувати студента' : 'Додати студента',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'Ім`я'),
          ),

          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Прізвище'),
          ),
          TextField(
            controller: _gradeController,
            decoration: const InputDecoration(labelText: 'Оцінка'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),

          DropdownButton<Department>(
            value: _selectedDepartment,
            isExpanded: true,
            onChanged: (new_Value) {
              if (new_Value == null) return;
              setState(() {
                _selectedDepartment = new_Value;
              });
            },
            items: Department.values.map((department) {
              return DropdownMenuItem(
                value: department,
                child: Text(department.name),
              );
            }).toList(),
          ),

          DropdownButton<Gender>(
            value: _selectedGender,
            isExpanded: true,
            onChanged: (new_Value) {
              if (new_Value == null) return;
              setState(() {
                _selectedGender = new_Value;
              });
            },
            items: Gender.values.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitData,
            child: Text(isEditing ? 'Зберегти зміни' : 'Додати студента'),
          )
        ],
      ),
    );
  }
}