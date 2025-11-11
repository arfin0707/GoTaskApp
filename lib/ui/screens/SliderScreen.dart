import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/widget/ScreenBackground.dart';
import 'package:task_manager_app_go_task/data/slider_model.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/utils/app_duration.dart';

class MoveToSliderScreen extends StatelessWidget {
  const MoveToSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SliderScreen());
  }
}

/// Data model for Slider pages

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final List<SliderPageData> _pages = const [
    SliderPageData(
      title: 'Organize your task',
      description:
          'Lorem ipsum dolor sit amet consectetur. Quam risus sem amet. Condimentum magna vitae mauris sed integer lacus nec arcu.',
      imagePath: 'assets/images/task.jpeg',
    ),
    SliderPageData(
      title: 'Organize your project',
      description:
          'Lorem ipsum dolor sit amet consectetur. Quam risus sem amet. Condimentum magna vitae mauris sed integer lacus nec arcu.',
      imagePath: 'assets/images/project.jpeg',
    ),
    SliderPageData(
      title: 'Always connect with team',
      description:
          'Lorem ipsum dolor sit amet consectetur. Quam risus sem amet. Condimentum magna vitae mauris sed integer lacus nec arcu.',
      imagePath: 'assets/images/team.jpeg',
    ),
  ];

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: AppDurations.pageTransition,
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to your next screen when on the last page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    }
  }

  void _skipToEnd() {
    _pageController.jumpToPage(_pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: ScreenBackground(
        child: Column(
          children: [
            /// Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skipToEnd,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                ),
              ),
            ),

            /// PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (_, index) {
                  final page = _pages[index];
                  return SliderPage(
                    data: page,
                    currentPage: _currentPage,
                    totalPages: _pages.length,
                    onNextPressed: _goToNextPage,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget representing a single Slider page
class SliderPage extends StatelessWidget {
  final SliderPageData data;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;

  const SliderPage({
    super.key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textWhite70,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Dot indicators
            /*        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => DotIndicator(isActive: currentPage == index),
            ),
          ),*/
            const SizedBox(height: 20),

            /// Centered image
            Expanded(
              child: Center(
                child: Image.asset(
                  data.imagePath,
                  height: height * 0.4,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// Bottom button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, -3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  elevation: 0,
                ),

                child: Text(
                  currentPage == totalPages - 1 ? "Get Started" : "Next",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),

        Positioned(
          top: 230, // adjust spacing above the button
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => DotIndicator(isActive: currentPage == index),
            ),
          ),
        ),
      ],
    );
  }
}

/// Dots indicator widget
class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.pageTransition,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 32 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
