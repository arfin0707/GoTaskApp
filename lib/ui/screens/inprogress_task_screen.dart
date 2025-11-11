import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/task_list_model.dart';
import 'package:task_manager_app_go_task/data/models/task_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/widget/TodoTaskCard.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key, this.onRefreshCounters});
  final VoidCallback? onRefreshCounters; // <- this is for TaskScreen counters

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTaskInprogess = false;
  List<TaskModel> _InProgressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            _getInProgressTaskList();
          },
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: !_getInProgressTaskInprogess,
                  replacement: const CenterCircuerProgessIndicator(),
                  child: _InProgressTaskList.isEmpty
                      ? const Center(
                          child: Text(
                            "No tasks in progress",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _InProgressTaskList.length,
                          itemBuilder: (context, index) {
                            return TodoTaskCard(
                              taskModel: _InProgressTaskList[index],
                              onRefreshList: () {
                                _getInProgressTaskList();
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

  Future<void> _getInProgressTaskList() async {
    _InProgressTaskList.clear();
    _getInProgressTaskInprogess = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.inProgressTaskList,
    );

    // 👇 Add this line to see the raw JSON response in the console
    print('✅ API Response: ${response.responseData}');

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _InProgressTaskList = taskListModel.taskList ?? [];
      widget.onRefreshCounters?.call(); // refresh counters immediately


      /*final TaskListModel taskListModel = TaskListModel.fromJson(response.reponseData);
      _InProgressTaskList = taskListModel.taskList ?? [];*/
      print('🟢 Parsed List Length: ${_InProgressTaskList.length}');
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }

    _getInProgressTaskInprogess = false;
    setState(() {});
  }
}
