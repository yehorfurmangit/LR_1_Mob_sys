
enum Gender { male, female }

class Students {
  final String firstName;
  final String lastName;
  final String departmentId; 
  final int grade;
  final Gender gender;

  Students({
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.gender,
    required this.grade,
  });
}