import 'package:employee/core/constants/constants.dart';
import 'package:employee/core/routes/app_routes.dart';
import 'package:employee/core/utils/utils.dart';
import 'package:employee/data/models/employee.dart';
import 'package:employee/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>('employeeBox');
  Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeUtils.theme,
      navigatorKey: navigatorKey,
      initialRoute: Routes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) {
        print("main");

        return ScrollConfiguration(
          behavior: const ScrollBehaviorModified(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              print("main ${constraints.constrainWidth()}");

               if(kIsWeb) {
                      ScreenUtil.init(
                        constraints,
                      );
              return child ?? const SizedBox.shrink();
                    }
                  else return OrientationBuilder(builder: (context, orientation){
                print("main $orientation");
                if(orientation == Orientation.portrait){
                  print("main portrait");
                  ScreenUtil.init(
                    constraints,
                    designSize: Size(428, 926),
                  );
                  return child ?? const SizedBox.shrink();
                }else{
                  ScreenUtil.init(
                    constraints,
                    designSize: Size(926, 428),
                  );
                  return child ?? const SizedBox.shrink();
                }
              });

            },
          ),
        );
      },
    );
  }
}



class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}