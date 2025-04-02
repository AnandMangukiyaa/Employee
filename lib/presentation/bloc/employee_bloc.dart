import 'package:employee/data/repositories/employee_respository.dart';
import 'package:employee/domain/usecases/add_employee.dart';
import 'package:employee/domain/usecases/delete_employee.dart';
import 'package:employee/domain/usecases/get_all_employee.dart';
import 'package:employee/domain/usecases/update_employee.dart';
import 'package:employee/presentation/bloc/employee_event.dart';
import 'package:employee/presentation/bloc/employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final GetAllEmployeesUseCase getAllEmployeesUseCase;
  final AddEmployeeUseCase addEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;
  final DeleteEmployeeUseCase deleteEmployeeUseCase;



  EmployeeBloc(this.addEmployeeUseCase,this.getAllEmployeesUseCase,this.updateEmployeeUseCase,this.deleteEmployeeUseCase) : super(EmployeeInitial()) {


    on<LoadEmployees>((event, emit) async {
      emit(EmployeeLoading());
      final employees = await getAllEmployeesUseCase();
      emit(EmployeeLoaded(employees));
    });

    on<AddEmployee>((event, emit) async {
      await addEmployeeUseCase(event.employee);
      add(LoadEmployees());
    });

    on<UpdateEmployee>((event, emit) async {
      await updateEmployeeUseCase(event.employee);
      add(LoadEmployees());
    });

    on<DeleteEmployee>((event, emit) async {
      await deleteEmployeeUseCase(event.employee);
      add(LoadEmployees());
    });
  }
}