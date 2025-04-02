import 'package:hive/hive.dart';
part 'employee.g.dart';
@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? designation;

  @HiveField(2)
  String? startDate;

  @HiveField(3)
  String? endDate;

  Employee({
    this.name,
    this.designation,
    this.startDate,
    this.endDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      designation: json['designation'],
      startDate: json['start_date'] ,
      endDate: json['end_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'designation': designation,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}