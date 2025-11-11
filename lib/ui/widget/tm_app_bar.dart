import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/user_model.dart';
import 'package:task_manager_app_go_task/ui/screens/profile_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';

import '../controllers/auth_controller.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.isProfileScreenOpen = false});

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );

      },
      child: AppBar(
        backgroundColor: AppColors.primaryLight,
        // purple color
        elevation: 0,
        toolbarHeight: 80,
        titleSpacing: 16,
        title: ValueListenableBuilder<UserModel?>(
          valueListenable: AuthController.userDataNotifier,
          builder: (context, user, _ ) {
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
            return Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage:avatarProvider,
/*                  backgroundImage: AssetImage(
                    'assets/profile.jpg',
                  ), // your profile image*/
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthController.userData?.fullName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AuthController.userData?.email ?? '',
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white, size: 26),
                SizedBox(width: 18),
                Icon(Icons.notifications_none, color: Colors.white, size: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
// Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
