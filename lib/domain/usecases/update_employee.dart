import 'package:employee/data/models/employee.dart';
import 'package:employee/data/repositories/employee_respository.dart';

class UpdateEmployeeUseCase {
  final EmployeeRepository repository;
  UpdateEmployeeUseCase(this.repository);
  Future<void> call(Employee employee) => repository.updateEmployee(employee);
}