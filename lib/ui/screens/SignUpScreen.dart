import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/Container_shadow.dart';
import 'package:task_manager_app_go_task/ui/widget/ScreenBackground.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ScreenBackground(
      bottomContainerHeight: 0.82, //  custom height
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Join With Us",
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: AppColors.grey50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Welcome, please create your account using email address",
                    textAlign: TextAlign.center, // optional, centers the text
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.grey50,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 70),

            _buildSignUpForrm(textTheme),

            SizedBox(height: 20),
            Visibility(
              visible: _inProgress==false,
              replacement: CenterCircuerProgessIndicator(),
              child: ElevatedButton(
                onPressed: () {
                  _onTapSignUpButton();
                },
                child: Text(
                  'Register',
                  style: textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),

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

  Widget _buildSignUpForrm(TextTheme textTheme) {
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
              SizedBox(height: 8),
              ContainerShaadow(
                child: TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter valid Email';
                    }
                  },
                ),
              ),

              SizedBox(height: 16),

              Text(
                'First Name',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              ContainerShaadow(
                child: TextFormField(
                  controller: _firstNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter your first name',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your first name';
                    }
                  },
                ),
              ),
              SizedBox(height: 16),

              Text(
                'Last Name',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              ContainerShaadow(
                child: TextFormField(
                  controller: _lastNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: 'Enter your last name'),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your last name';
                    }
                  },
                ),
              ),
              SizedBox(height: 16),

              Text(
                'Mobile',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              ContainerShaadow(
                child: TextFormField(
                  controller: _mobileTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your mobile number';
                    }
                  },
                ),
              ),
              SizedBox(height: 16),

              Text(
                'Your Password',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 8),
              TextFormField(
                controller: _passwordTEController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter your password'),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your password';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _onTapSignUpButton() {
    if (_formkey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    _inProgress = true;
    setState(() {});

    Map<String,dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
      "photo": ""

    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody
    );

    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextField();
      showSnackbarMessage(context, 'New user created');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SignInScreen()),
            (route) => false,
      );
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextField() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  void _onTapSignInButton() {
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );*/
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
