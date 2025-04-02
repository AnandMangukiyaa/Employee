import 'package:employee/data/models/employee.dart';
import 'package:hive/hive.dart';

class HiveService {
  final Box<Employee> employeeBox = Hive.box<Employee>('employeeBox');
  List<Employee> getAllEmployees() => employeeBox.values.toList();
  Future<void> addEmployee(Employee employee) async => employeeBox.add(employee);
  Future<void> updateEmployee(Employee employee) async {
    final box = Hive.box<Employee>('employeeBox');
    if (box.containsKey(employee.key)) {
      await box.put(employee.key, employee);
    }
  }
  Future<void> deleteEmployee(Employee employee) async => employee.delete();
}