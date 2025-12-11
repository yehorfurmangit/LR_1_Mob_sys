import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/department.dart';

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

  Department _selectedDepartment = availableDepartments[0];
  Gender _selectedGender = Gender.male;

  @override
  void initState() {
    super.initState();
    if (widget.studentToEdit != null) {
      _firstNameController.text = widget.studentToEdit!.firstName;
      _lastNameController.text = widget.studentToEdit!.lastName;
      _gradeController.text = widget.studentToEdit!.grade.toString();
      
      _selectedDepartment = availableDepartments.firstWhere(
        (dept) => dept.id == widget.studentToEdit!.departmentId,
        orElse: () => availableDepartments[0],
      );
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
        firstName: enteredFirstName,
        lastName: enteredLastName,
        departmentId: _selectedDepartment.id,
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
            onChanged: (newValue) {
              if (newValue == null) return;
              setState(() {
                _selectedDepartment = newValue;
              });
            },
            items: availableDepartments.map((department) {
              return DropdownMenuItem(
                value: department,
                child: Row(
                  children: [
                    Icon(department.icon, color: department.color),
                    const SizedBox(width: 10),
                    Text(department.name),
                  ],
                ),
              );
            }).toList(),
          ),

          DropdownButton<Gender>(
            value: _selectedGender,
            isExpanded: true,
            onChanged: (newValue) {
              if (newValue == null) return;
              setState(() {
                _selectedGender = newValue;
              });
            },
            items: Gender.values.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender.name.toUpperCase()),
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