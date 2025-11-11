import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/task_list_model.dart';
import 'package:task_manager_app_go_task/data/models/task_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/widget/TodoTaskCard.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key, this.onRefreshCounters});
  final VoidCallback? onRefreshCounters; // <- this is for TaskScreen counters


  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInprogess = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTaskList();
          },
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: !_getCompletedTaskInprogess,
                  replacement: const CenterCircuerProgessIndicator(),
                  child: _completedTaskList.isEmpty
                      ? const Center(
                          child: Text(
                            "No completed tasks yet",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _completedTaskList.length,
                          itemBuilder: (context, index) {
                            return TodoTaskCard(
                              taskModel: _completedTaskList[index],
                              onRefreshList: () {
                                _getCompletedTaskList();
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
        /*        floatingActionButton: FloatingActionButton(
          onPressed: _onTabFAB,
          child: Icon(Icons.add),
        ),*/
      ),
    );
  }

  /*

  Future<void> _onTabFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );

    if(shouldRefresh == true){
      _getNewTaskList();

    }
  }
*/

  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskInprogess = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.completedTaskList,
    );

    // 👇 Add this line to see the raw JSON response in the console
    print('✅ API Response: ${response.responseData}');

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _completedTaskList = taskListModel.taskList ?? [];
      widget.onRefreshCounters?.call(); // refresh counters immediately

    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }

    _getCompletedTaskInprogess = false;
    setState(() {});
  }
}
