import 'dart:io';

import 'package:employee/data/models/employee.dart';
import 'package:employee/main.dart';
import 'package:employee/presentation/views/add_employee_page.dart';
import 'package:employee/presentation/views/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String addEmployee = '/add_employee';
}


class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.addEmployee:
        return MaterialPageRoute(builder: (_) => AddEmployeePage(args != null ? args as Employee : null));
      default:
        return null;
    }
  }
}
