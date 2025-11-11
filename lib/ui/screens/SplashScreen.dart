import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/SliderScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/main_bottom_navbar_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/utils/assets_path.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));

    await AuthController.getAccessToken();
    if(AuthController.isloggedIn()){
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen()),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SliderScreen()),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.logo, width: 100),
            Text(
              'Go Task',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
