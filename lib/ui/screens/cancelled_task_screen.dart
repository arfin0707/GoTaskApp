import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/task_list_model.dart';
import 'package:task_manager_app_go_task/data/models/task_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/widget/TodoTaskCard.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key, this.onRefreshCounters});
  final VoidCallback? onRefreshCounters; // <- this is for TaskScreen counters


  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInprogess = false;
  List<TaskModel> _CancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            _getCancelledTaskList();
          },
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: !_getCancelledTaskInprogess,
                  replacement: const CenterCircuerProgessIndicator(),
                  child: _CancelledTaskList.isEmpty
                      ? const Center(
                          child: Text(
                            "No tasks have been cancelled yet.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _CancelledTaskList.length,
                          itemBuilder: (context, index) {
                            return TodoTaskCard(
                              taskModel: _CancelledTaskList[index],
                              onRefreshList: () {
                                _getCancelledTaskList();
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

  Future<void> _getCancelledTaskList() async {
    _CancelledTaskList.clear();
    _getCancelledTaskInprogess = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.cancelledTaskList,
    );

    // 👇 Add this line to see the raw JSON response in the console
    print('✅ API Response: ${response.responseData}');

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _CancelledTaskList = taskListModel.taskList ?? [];
      widget.onRefreshCounters?.call(); // refresh counters immediately

    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }

    _getCancelledTaskInprogess = false;
    setState(() {});
  }
}
