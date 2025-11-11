import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/user_model.dart';
import 'package:task_manager_app_go_task/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/profile_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserModel?>(
        valueListenable: AuthController.userDataNotifier,
        builder: (context, user, _ ) {

          //👇 for upadte image
          ImageProvider avatarProvider;
          if (user?.photo != null && user!.photo!.isNotEmpty) {
            // Detect whether it's base64 or network URL
            if (user.photo!.startsWith('http')) {
              avatarProvider = NetworkImage(user.photo!);
            } else {
              avatarProvider = MemoryImage(base64Decode(user.photo!));
            }
          } else {
            avatarProvider = const AssetImage('assets/images/profile.jpg');
          }
          return Column(
            children: [
              // Header Section
              Container(
                /*          decoration: const BoxDecoration(
              color: Color(0xFF7A4DFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),*/
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*              const SizedBox(height: 30),
                const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Hello Robert Fox",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),*/
                  ],
                ),
              ),

              // Profile Card
              Transform.translate(
                offset: const Offset(0, -40),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        //👇 for upadte image
                        backgroundImage:avatarProvider,
                        /*      backgroundImage: AssetImage(
                            'assets/images/profile_pic.png'),*/
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AuthController.userData?.fullName ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AuthController.userData?.email ?? '',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  value: 0.4,
                                  strokeWidth: 5,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor: const AlwaysStoppedAnimation(
                                    Colors.deepPurple,
                                  ),
                                ),
                              ),
                              const Text("40%", style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Menu List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ProfileMenuTile(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                    const ProfileMenuTile(
                      icon: Icons.group,
                      title: 'Team',
                      onTap: null,
                    ),
                    const ProfileMenuTile(
                      icon: Icons.description,
                      title: 'Terms & Condition',
                      onTap: null,
                    ),
                    const ProfileMenuTile(
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: null,
                    ),
                    const ProfileMenuTile(
                      icon: Icons.help,
                      title: 'FAQs',
                      onTap: null,
                    ),
                    ProfileMenuTile(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () => _onTaplogoutButton(context),
                      /*  onTap: () async {
                    await AuthController.clearUserDta();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                      (predicate) => false,
                    );
                  },*/

                      color: AppColors.dangerLight,
                    ),


                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          );
        },
    );
  }
}


void _onTaplogoutButton(context){
  final theme = Theme.of(context);
  // final cs = theme.colorScheme;
  // final cs = AppColors.dangerLight;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(Icons.logout, color: AppColors.dangerLight),
          const SizedBox(width: 8),
          Text(
            'Logout?',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.dangerLight,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.black_soft,
          height: 1.5,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context); // Close dialog first
            await AuthController.clearUserDta();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (predicate) => false,
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.dangerLight,
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
            overlayColor: AppColors.dangerLight.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}
class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? color;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
