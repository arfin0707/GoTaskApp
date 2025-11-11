/*
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  final double bottomContainerHeight; // 👈 new parameter

  const ScreenBackground({
    super.key,
    required this.child,
    this.bottomContainerHeight = 0.70, // 👈 default value
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          /// Bottom white container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * bottomContainerHeight, // 👈 use variable
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
            ),
          ),

          /// Slider content
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
*/


/*
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
          /// Bottom white container
          Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height * 0.70,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            ),
          ),
        ),

        /// Slider content
        SafeArea(
          child: child,
        ),
        ],
        ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  final double bottomContainerHeight;

  const ScreenBackground({
    super.key,
    required this.child,
    this.bottomContainerHeight = 0.70,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safeHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          /// নিচের সাদা container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: safeHeight * bottomContainerHeight,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
            ),
          ),

          /// উপরের content
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
