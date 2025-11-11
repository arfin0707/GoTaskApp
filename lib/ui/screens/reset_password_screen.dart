import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/SignUpScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/forgot_pass_email_address.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/Container_shadow.dart';
import 'package:task_manager_app_go_task/ui/widget/ScreenBackground.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});
  // const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _inProgress = false;
  // final String email;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ScreenBackground(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 85),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Set Password",
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: AppColors.grey50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Mimimum length password 8 characters with letter and number combination",
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 140),

            _buildSignInForrm(textTheme),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _onTapResetPassword();
              },
              child: Text(
                'Confirm',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 20),

            Center(
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SizedBox(height: 8), _buildSignUpSection()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      // textAlign: TextAlign.center,
      text: TextSpan(
        text: "Have account? ",
        style: const TextStyle(color: Colors.black, fontSize: 16),
        // default style
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,

            // optional: make it clickable
            // recognizer: TapGestureRecognizer()..onTap = () { /* Navigate to SignUp */ },
          ),
        ],
      ),
    );
  }

  Widget _buildSignInForrm(TextTheme textTheme) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Password',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 14),
          ContainerShaadow(
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                // label: 'Your Pasword'
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter new password';
                }
                return null;
              },
            ),
          ),

          SizedBox(height: 32),

          Text(
            'Confirm Password',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 14),
          ContainerShaadow(
            child: TextFormField(
              controller: _confirmController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm your password',
                // label: 'Your Pasword'
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Confirm your password';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTapResetPassword() {
      if (!_formkey.currentState!.validate()) {
        return;
      }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }


/*

  void _onTapResetPassword() async {
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Fill all fields')));
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final response = await NetworkCaller.postRequest(
      url: Urls.recoverResetPass,
      body: {"email": widget.email, "password": password},
    );

    if (response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage)));
    }
  }
*/


  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}
