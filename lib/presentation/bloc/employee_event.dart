import 'package:employee/data/models/employee.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadEmployees extends EmployeeEvent {}
class AddEmployee extends EmployeeEvent {
  final Employee employee;
  AddEmployee(this.employee);
}
class UpdateEmployee extends EmployeeEvent {
  final Employee employee;
  UpdateEmployee(this.employee);
}
class DeleteEmployee extends EmployeeEvent {
  final Employee employee;
  DeleteEmployee(this.employee);
}
