import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/SignUpScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/forgot_pass_otp_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/Container_shadow.dart';
import 'package:task_manager_app_go_task/ui/widget/ScreenBackground.dart';

class ForgotPassEmailAddressScreen extends StatefulWidget {
  const ForgotPassEmailAddressScreen({super.key});

  @override
  State<ForgotPassEmailAddressScreen> createState() =>
      _ForgotPassEmailAddressScreenState();
}

class _ForgotPassEmailAddressScreenState
    extends State<ForgotPassEmailAddressScreen> {
  TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _inProgress = false;

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
                  "Your Email Address",
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
                    "A 6-digit verification pin will send to your email address",
                    textAlign: TextAlign.center, // optional, centers the text
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 160),

            _buildVerifyEmailForm(textTheme),

            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _onTapNextButton();
              },
              child: Text(
                'Verify',
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
                children: [SizedBox(height: 8), _buildSignInSection()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInSection() {
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

  Widget _buildVerifyEmailForm(TextTheme textTheme) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Email',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 14),
          ContainerShaadow(
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Enter your email address'),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter valid Email';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

      void _onTapNextButton() {
      if (!_formkey.currentState!.validate()) {
        return;
      }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPassOtpScreen(email: '',)),
    );
  }


  // Step 1: Send OTP
/*  void _onTapNextButton() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter your email')));
      return;
    }

    final response =
    await NetworkCaller.getRequest(url: Urls.recoverVerifyEmail(email));

    if (response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPassOtpScreen(email: email)),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage)));
    }
  }*/





  void _onTapSignInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
    // Navigator.pop(context);
  }
}
