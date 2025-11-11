import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/user_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/controllers/auth_controller.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/Container_shadow.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';
import 'package:task_manager_app_go_task/ui/widget/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  bool _updateProfileInProgress = false;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
    // _passwordTEController.text=AuthController.userData?.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(isProfileScreenOpen: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 32),
              Text(
                "Update Profile",
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),

              _buildPhotoPicker(),
              SizedBox(height: 20),

              _buildSignUpForrm(textTheme),
              SizedBox(height: 20),
              Visibility(
                visible: !_updateProfileInProgress,
                replacement: CenterCircuerProgessIndicator(),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _updateProfile();
                    }
                  },
                  child: Text(
                    'Update',
                    style: textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  void _onTapSignUpButton() {
    //TODO: implement on tap SignUp button
  }*/

  Widget _buildSignUpForrm(TextTheme textTheme) {
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
          SizedBox(height: 8),
          ContainerShaadow(
            child: TextFormField(
              enabled: false,
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Enter your email address'),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter your email';
                }
                return null;
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
              decoration: InputDecoration(hintText: 'Enter your first name'),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter your first name';
                }
                return null;
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
              decoration: InputDecoration(hintText: 'Enter your last name'),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter your last name';
                }
                return null;
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
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: 'Enter your mobile number'),
              validator: (String? value){
                if(value?.trim().isEmpty ?? true){
                  return 'Enter your mobile number';
                }
                return null;
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
          ContainerShaadow(
            child: TextFormField(
              obscureText: true,
              controller: _passwordTEController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                // label: 'Your Pasword'
              ),

            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfile() async {
    try {
      _updateProfileInProgress = true;
      setState(() {});

      Map<String, dynamic> requestBody = {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
      };

      if (_passwordTEController.text.isNotEmpty) {
        requestBody['password'] = _passwordTEController.text;
      }

      if (_selectedImage != null) {
        final compressed = await FlutterImageCompress.compressWithFile(
          _selectedImage!.path,
          quality: 50, // reduce size for faster upload
        );
        if (compressed != null) {
          String convertedImage = base64Encode(compressed);
          requestBody['photo'] = convertedImage;
        }
      }
/*
      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        String convertedImage = base64Encode(imageBytes);
        requestBody['photo'] = convertedImage;
      }*/

      final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.profileUpdate,
        body: requestBody,
      );

      _updateProfileInProgress = false;
      setState(() {});

      if (response.isSuccess) {
      /*  UserModel userModel = UserModel.fromJson(requestBody);
        AuthController.saveUserData(userModel);*/

        // Create updated user model
        UserModel userModel = UserModel.fromJson(requestBody);
        // Save to shared preferences (persistent)
        await AuthController.saveUserData(userModel);

        // Also update the in-memory user data instantly
        // AuthController.userData = userModel;
        setState(() {});

        showSnackbarMessage(context, 'Profile has been updated successfully');

      } else {
        showSnackbarMessage(context, response.errorMessage);
      }
    } catch (e) {
      _updateProfileInProgress = false;
      setState(() {});
      showSnackbarMessage(context, 'Something went wrong: $e');
    }
  }
/*
  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.profileUpdate,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    setState(() {});

    if(response.isSuccess){
      // AuthController.saveUserData(userModel);
      showSnackbarMessage(context, 'Profile has been updated');

    }else{
      showSnackbarMessage(context, response.errorMessage);

    }
  }
*/

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(_getSelectedPhotoTitle()),
          ],
        ),
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Select Photo';
  }

  Future<void> _pickImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }
}
