import 'package:employee/data/models/employee.dart';
import 'package:employee/data/repositories/employee_respository.dart';

class GetAllEmployeesUseCase {
  final EmployeeRepository repository;
  GetAllEmployeesUseCase(this.repository);
  Future<List<Employee>> call() => repository.getAllEmployees();
}