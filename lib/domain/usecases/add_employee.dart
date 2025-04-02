import 'package:employee/data/models/employee.dart';
import 'package:employee/data/repositories/employee_respository.dart';

class AddEmployeeUseCase {
  final EmployeeRepository repository;
  AddEmployeeUseCase(this.repository);
  Future<void> call(Employee employee) => repository.addEmployee(employee);
}