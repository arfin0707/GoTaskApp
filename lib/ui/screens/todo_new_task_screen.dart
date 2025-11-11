import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/task_list_model.dart';
import 'package:task_manager_app_go_task/data/models/task_model.dart';
import 'package:task_manager_app_go_task/data/models/task_status_count_model.dart';
import 'package:task_manager_app_go_task/data/models/task_status_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app_go_task/ui/widget/TodoTaskCard.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class TodoNewTaskScreen extends StatefulWidget {
  const TodoNewTaskScreen({super.key, this.onRefreshCounters});
  final VoidCallback? onRefreshCounters; // <- this is for TaskScreen counters


  @override
  State<TodoNewTaskScreen> createState() => _TodoNewTaskScreenState();
}

class _TodoNewTaskScreenState extends State<TodoNewTaskScreen> {
  bool _getNewTaskInprogess = false;
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            _getNewTaskList();
          },
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: !_getNewTaskInprogess,
                  replacement: const CenterCircuerProgessIndicator(),
                  child: _newTaskList.isEmpty
                      ? const Center(
                          child: Text(
                            "No new tasks have been added",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _newTaskList.length,
                          itemBuilder: (context, index) {
                            return TodoTaskCard(
                              taskModel: _newTaskList[index],
                              onRefreshList: () {
                                _getNewTaskList();
                                // widget.onRefreshCounters?.call(); // refresh counters immediately

                              },

                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onTabFAB,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _onTabFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );

    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskInprogess = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.newTaskList,
    );
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _newTaskList = taskListModel.taskList ?? [];
      widget.onRefreshCounters?.call(); // refresh counters immediately

    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }

    _getNewTaskInprogess = false;
    setState(() {});
  }
}
