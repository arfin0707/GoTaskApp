import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/ui/screens/profile_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/tabs/message_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/tabs/profile_tab_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/tabs/project_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/tabs/tab_bar_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/tabs/task_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/tm_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {

  int _selectedIndex=0;
  final List<Widget> _screens = const [
    TaskScreen(),
    ProjectScreen(),
    MessageScreen(),
    ProfileTabScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
/*      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex ,
        onDestinationSelected: (int index){
          _selectedIndex =index;
          setState(() {

          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.list_alt), label: 'Task'),
          NavigationDestination(icon: Icon(Icons.file_copy_sharp), label: 'Project'),
          NavigationDestination(icon: Icon(Icons.chat_outlined), label: 'Message'),
          NavigationDestination(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
      ),*/


      bottomNavigationBar: NavigationBar(
        // backgroundColor: Colors.white, // পুরো বার সাদা রাখার জন্য
        indicatorColor: Colors.transparent, // selected item এ কোনো background না দিতে
        selectedIndex: _selectedIndex,
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle( color: AppColors.primary);
          }
          return const TextStyle(color: Colors.grey);
        }),

        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.featured_play_list_outlined,color: Colors.grey),
            selectedIcon: Icon(Icons.featured_play_list_rounded,  color: AppColors.primary),
            label: 'Task',
          ),
          NavigationDestination(
            icon: Icon(Icons.file_copy_outlined, color: Colors.grey),
            selectedIcon: Icon(Icons.file_copy_sharp, color: AppColors.primary),
            label: 'Project',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined, color: Colors.grey),
            selectedIcon: Icon(Icons.chat,  color: AppColors.primary),
            label: 'Message',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.grey),
            selectedIcon: Icon(Icons.person,  color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      ),




    );
  }
}
