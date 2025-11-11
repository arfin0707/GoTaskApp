import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/screens/SplashScreen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
class TaskAManagerApp extends StatefulWidget {
  const TaskAManagerApp({super.key});
  static final GlobalKey<NavigatorState> navigatoKey = GlobalKey<NavigatorState>();
  @override
  State<TaskAManagerApp> createState() => _TaskAManagerAppState();
}

class _TaskAManagerAppState extends State<TaskAManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskAManagerApp.navigatoKey,
      theme: ThemeData(
        colorSchemeSeed:AppColors.primary,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      home: SplashScreen(),
    );
  }
}

InputDecorationTheme _inputDecorationTheme (){
  return InputDecorationTheme(
    border: _inputBorder(),
    enabledBorder: _inputBorder(),
    errorBorder:_inputBorder(),
    focusedBorder:_inputBorder(),
    focusedErrorBorder: _inputBorder(),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 10),

  );
}

OutlineInputBorder _inputBorder(){
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black.withOpacity(0.1),
      width: 2,
    ),
    // borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(8),
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData(){
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      fixedSize: Size.fromWidth(double.maxFinite),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}