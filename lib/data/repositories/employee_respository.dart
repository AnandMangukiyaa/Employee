import 'package:employee/data/models/employee.dart';
import 'package:employee/sevices/hive_service.dart';

class EmployeeRepository {
  final HiveService hiveService;
  EmployeeRepository(this.hiveService);
  Future<List<Employee>> getAllEmployees() async => hiveService.getAllEmployees();
  Future<void> addEmployee(Employee employee) async => hiveService.addEmployee(employee);
  Future<void> updateEmployee(Employee employee) async => hiveService.updateEmployee(employee);
  Future<void> deleteEmployee(Employee employee) async => hiveService.deleteEmployee(employee);
}
