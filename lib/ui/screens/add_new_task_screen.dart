import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';
import 'package:task_manager_app_go_task/ui/widget/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  bool _inProgress = false;
  bool _shouldRefreshPreviousPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 42),
                Text(
                  "Add New Task",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: 'Title'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter task description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
        
                Visibility(
                  visible: !_inProgress,
                  replacement: CenterCircuerProgessIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTabSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSubmitButton() {
/*    if (!_formkey.currentState!.validate()) {
      return;
    }
    _addNewTask();*/
    if (_formkey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'title': _titleTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'status': 'New',
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTask,
      body: requestBody
    );
    _inProgress=false;
    setState(() {

    });
    if (response.isSuccess) {
      _shouldRefreshPreviousPage=true;
      _clearTextField();
      showSnackbarMessage(context, 'New task added');
      Navigator.pop(context, _shouldRefreshPreviousPage);

    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextField() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
