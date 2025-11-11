import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/screens/SignInScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/SignUpScreen.dart';
import 'package:task_manager_app_go_task/ui/screens/reset_password_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/Container_shadow.dart';
import 'package:task_manager_app_go_task/ui/widget/ScreenBackground.dart';

class ForgotPassOtpScreen extends StatefulWidget {
  // const ForgotPassOtpScreen({super.key});
  final String email;

  const ForgotPassOtpScreen({super.key, required this.email});

  @override
  State<ForgotPassOtpScreen> createState() => _ForgotPassOtpScreenState();
}

class _ForgotPassOtpScreenState extends State<ForgotPassOtpScreen> {
  TextEditingController _otpController = TextEditingController();
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
                  "Pin Verification",
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
                _onTapVerifyButton();
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
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Didn't receive the code? ",
        style: const TextStyle(color: Colors.black, fontSize: 16),
        // default style
        children: [
          TextSpan(
            text: 'Resend',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapResendButton,

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

          /*        ContainerShaadow(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Enter your email address'),
            ),
          ),*/
          PinCodeTextField(
            controller: _otpController,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            appContext: context,
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            /*boxShadows: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 1,
              ),

            ],*/
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter verification code';
              }
              return null;
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 50,
              fieldWidth: 40,

              // 👇 Common fill color
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,

              // 👇 White border for all states
              activeColor: Colors.grey[200],
              inactiveColor: Colors.grey[200],
              selectedColor: Colors.grey[200],

              // Override decorations for shadow
              activeBoxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 1.5),
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
              inActiveBoxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 1.5),
                  blurRadius: 3,
                  spreadRadius: 0.5,
                ),
              ],
            ),
          ),

          SizedBox(height: 8),
        ],
      ),
    );
  }

    void _onTapVerifyButton() {
      if (!_formkey.currentState!.validate()) {
        return;
      }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ResetPasswordScreen(email: '',)),
        (_) => false

    );  }


  // Step 2: Verify OTP

/*  void _onTapVerifyButton() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter OTP')));
      return;
    }

    final response = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyOTP(widget.email, otp));

    if (response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: widget.email)),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage)));
    }
  }*/



  void _onTapResendButton() {
    /*    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (_) => false

    );*/
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SignInScreen()),
    // );
    // Navigator.pop(context);
  }
}
