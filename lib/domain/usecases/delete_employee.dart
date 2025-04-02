import 'package:employee/data/models/employee.dart';
import 'package:employee/data/repositories/employee_respository.dart';

class DeleteEmployeeUseCase {
  final EmployeeRepository repository;
  DeleteEmployeeUseCase(this.repository);
  Future<void> call(Employee employee) => repository.deleteEmployee(employee);
}