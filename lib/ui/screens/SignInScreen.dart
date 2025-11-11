import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/login_model.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/user_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_go_task/ui/screens/SignUpScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/forgot_pass_email_address.dart';
import 'package:task_manager_app_go_task/ui/screens/main_bottom_navbar_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/Container_shadow.dart';
import 'package:task_manager_app_go_task/ui/widget/ScreenBackground.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                  "Get Started with",
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
                    "Welcome, please login your account using email and password",
                    textAlign: TextAlign.center, // optional, centers the text
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 140),

            _buildSignInForrm(textTheme),

            // SizedBox(height: 20),
            Visibility(
              visible: !_inProgress,
              // visible: _inProgress==false,
              replacement: CenterCircuerProgessIndicator(),
              child: ElevatedButton(
                onPressed: () {
                  _onTapLoginButton();
                },
                child: Text(
                  'Login',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Center(
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _onTapForgetPasswordButton();
                    },
                    child: Text(
                      'Forgot Password?',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),

                  SizedBox(height: 8),

                  _buildSignUpSection(),
                ],
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
        text: "Don't have an account? ",
        style: const TextStyle(color: Colors.black, fontSize: 16),
        // default style
        children: [
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,

            // optional: make it clickable
            // recognizer: TapGestureRecognizer()..onTap = () { /* Navigate to SignUp */ },
          ),
        ],
      ),
    );
  }

  Widget _buildSignInForrm(TextTheme textTheme) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
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
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
              SizedBox(height: 32),

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
                  controller: _passwordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    // label: 'Your Pasword'
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter valid Password';
                    }
                    if (value!.length <= 5) {
                      return 'Enter a passowrd more than 6 characters';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _signIn();

    /*    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen()),
          (_) => false,

    );*/
  }

  Future<void> _signIn() async {
    _inProgress = true;
    setState(() {});
    Map<String,dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody
    );
    debugPrint("🔹 LOGIN RESPONSE: ${response.responseData}");

    _inProgress = false;
    setState(() {});

    /*
    if (response.isSuccess) {
      LoginModel loginModel =LoginModel.fromJson(response.responseData);
      // await AuthController.saveAccessToken(response.reponseData['token']);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!.first);
      // await AuthController.saveUserData(UserModel.fromJson(loginModel.data!.first as Map<String, dynamic>));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen()),
        (value) => false,
      );
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }*/

    if (response.isSuccess) {
      try {
        //LoginModel loginModel = LoginModel.fromJson(response.responseData);
        LoginModel loginModel = LoginModel.fromJson(response.responseData);

        if (loginModel.token == null || loginModel.data == null) {
          showSnackbarMessage(context, 'Invalid login data', true);
          return;
        }
        // await AuthController.saveAccessToken(loginModel.token!);
        // await AuthController.saveUserData(loginModel.data!.first);

        await AuthController.saveAccessToken(loginModel.token!);
        await AuthController.saveUserData(loginModel.data!);
        setState(() {});
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainBottomNavBarScreen()),
              (route) => false,
        );
      } catch (e) {
        debugPrint("Parsing error: $e");
        showSnackbarMessage(context, 'Failed to parse login response', true);
      }
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapForgetPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPassEmailAddressScreen(),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}
