


import 'package:employee/data/repositories/employee_respository.dart';
import 'package:employee/domain/usecases/add_employee.dart';
import 'package:employee/domain/usecases/delete_employee.dart';
import 'package:employee/domain/usecases/get_all_employee.dart';
import 'package:employee/domain/usecases/update_employee.dart';
import 'package:employee/presentation/bloc/employee_bloc.dart';
import 'package:employee/sevices/hive_service.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static void init() {
    GetIt.I.registerFactory(()=>HiveService());

    GetIt.I.registerFactory(()=>EmployeeRepository(GetIt.I()));

    GetIt.I.registerLazySingleton(() {
      return AddEmployeeUseCase(GetIt.I());
    });

    GetIt.I.registerLazySingleton(() {
      return UpdateEmployeeUseCase(GetIt.I());
    });
    GetIt.I.registerLazySingleton(() {
      return DeleteEmployeeUseCase(GetIt.I());
    });
    GetIt.I.registerLazySingleton(() {
      return GetAllEmployeesUseCase(GetIt.I());
    });

    GetIt.I.registerLazySingleton(() {
      return EmployeeBloc(GetIt.I(), GetIt.I(), GetIt.I(), GetIt.I(),);
    });


  }
}
