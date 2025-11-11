/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'network_caller.dart'; // Your NetworkCaller class
import 'urls.dart'; // Your Urls class
import 'forgot_pass_otp_screen.dart';
import 'reset_password_screen.dart';
import 'sign_in_screen.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _inProgress = false;

  // Step 1: Send OTP
  void _onTapNextButton() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    final url = Urls.recoverVerifyEmail(email);

    try {
      final response = await NetworkCaller.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final body = response.responseData;

        if (body['status'] == 'success') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgotPassOtpScreen(email: email)),
          );
        } else {
          final data = body['data'];
          String errorMessage = 'Failed to send OTP';

          if (data is String) {
            errorMessage = data;
          } else if (data is Map) {
            errorMessage = data['response'] ?? errorMessage;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send OTP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Step 2: Verify OTP
  void _onTapVerifyButton(String email) async {
    if (!_formkey.currentState!.validate()) return;

    final otp = _otpController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email is missing. Please try again.')),
      );
      return;
    }

    setState(() => _inProgress = true);

    final encodedEmail = Uri.encodeComponent(email);
    final url =
        "http://10.0.2.2/task_manager_api/api/RecoverVerifyOTP.php?email=$encodedEmail&otp=$otp";

    try {
      final response = await NetworkCaller.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final body = response.responseData;
        if (body['status'] == 'success') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(email: email),
            ),
          );
        } else {
          String message = 'Invalid OTP';
          final data = body['data'];
          if (data is Map) message = data['response'] ?? message;
          if (data is String) message = data;

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid OTP')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _inProgress = false);
    }
  }

  // Step 3: Reset Password
  void _onTapResetPassword(String email) async {
    if (!_formkey.currentState!.validate()) return;

    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all fields')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final url = "http://10.0.2.2/task_manager_api/api/RecoverResetPass.php";
    final body = {
      "email": email,
      "password": password,
    };

    try {
      final response = await NetworkCaller.postRequest(url: url, body: body);

      if (response.isSuccess && response.responseData != null) {
        final body = response.responseData;

        if (body['status'] == 'success') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
                (_) => false,
          );
        } else {
          final data = body['data'];
          String errorMessage =
          data is String ? data : 'Failed to reset password';
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to reset password')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
              value == null || value.isEmpty ? 'Enter email' : null,
            ),
            ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
