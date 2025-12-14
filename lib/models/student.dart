
enum Gender { male, female }

class Students {
  final String id; 
  final String firstName;
  final String lastName;
  final String departmentId;
  final int grade;
  final Gender gender;

  Students({
    required this.id, 
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.gender,
    required this.grade,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      'grade': grade,
      'gender': gender.name, 
    };
  }

  factory Students.fromJson(Map<String, dynamic> json, String id) {
    return Students(
      id: id,
      firstName: json['firstName'],
      lastName: json['lastName'],
      departmentId: json['departmentId'],
      grade: json['grade'],
      gender: Gender.values.firstWhere((e) => e.name == json['gender']),
    );
  }
}