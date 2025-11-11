import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/task_status_count_model.dart';
import 'package:task_manager_app_go_task/data/models/task_status_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/completed_task_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/inprogress_task_screen.dart';
import 'package:task_manager_app_go_task/ui/screens/todo_new_task_screen.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> taskItems = [
    {
      'title': 'Total Task',
      'count': '50 Task',
      'icon': Icons.list_alt,
      'color': AppColors.primaryLight,
    },
    {
      'title': 'In-Progress',
      'count': '5 Task',
      'icon': Icons.cached_outlined,
      'color': AppColors.softPurple,
    },
    {
      'title': 'Completed',
      'count': '30 Task',
      'icon': Icons.check_circle,
      'color': AppColors.tealGreen,
    },
    {
      'title': 'Cancelled',
      'count': '20 Task',
      'icon': Icons.cancel_rounded,
      'color': AppColors.softRed,
    },
  ];
  bool _getTaskStatusCountListnprogess = false;
  List<TaskStatusModel> _taskStatusCountList = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    _tabController = TabController(length: 4, vsync: this);
    _getTaskStatusCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCounterScroll(),

        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              // Align tabs to the start without offset
              indicator: const BoxDecoration(),
              dividerColor: Colors.transparent,
              labelColor: AppColors.primary,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              tabs: [
                Text(
                  "To do",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "In-Progress",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Completed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Cancelled",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),

        /*          // --- Tab content ---
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                about_me(),
                security_tab(),
                Setting_tab(),
                // Center(child: Text('Settings Content')),
              ],
            ),
          ),*/
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              TodoNewTaskScreen(onRefreshCounters: _getTaskStatusCount),
              InProgressTaskScreen(onRefreshCounters: _getTaskStatusCount),
              CompletedTaskScreen(onRefreshCounters: _getTaskStatusCount),
              CancelledTaskScreen(onRefreshCounters: _getTaskStatusCount),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCounterScroll() {
    // Define color + icon map
    final Map<String, Map<String, dynamic>> taskItems = {
      'New': {'color': AppColors.primaryLight, 'icon': Icons.fiber_new},
      'Progress': {'color': AppColors.softPurple, 'icon': Icons.timelapse},
      'Completed': {'color': AppColors.tealGreen, 'icon': Icons.done},
      'Cancelled': {'color': AppColors.softRed, 'icon': Icons.cancel},
    };

    // Helper to get count from API data
    int getCount(String status) {
      final task = _taskStatusCountList.firstWhere(
            (t) => t.sId == status,
        orElse: () => TaskStatusModel(sId: status, sum: 0),
      );
      return task.sum ?? 0;
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _getTaskStatusCount(); // fetch API data
      },
      child: Container(
        width: double.infinity,
        color: AppColors.grey50,
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: 100,
          child: _getTaskStatusCountListnprogess
              ? const CenterCircuerProgessIndicator()
              : ListView(
            scrollDirection: Axis.horizontal,
            children: taskItems.entries.map((entry) {
              final status = entry.key;
              final style = entry.value;
              final count = getCount(status);

              return Container(
                margin: const EdgeInsets.all(8),
                width: 190,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: style['color'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.whiteTranparent,
                      child: Icon(style['icon'], color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$count',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }





  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTaskStatusCountListnprogess = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskStatusCount,
    );
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(
        response.responseData,
      );
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackbarMessage(context, response.errorMessage, true);
    }

    _getTaskStatusCountListnprogess = false;
    setState(() {});
  }


}


/*
Widget buildCounterScroll() {
  return RefreshIndicator(
    onRefresh: () async {
      _getTaskStatusCount();
    },
    child: Container(
      width: double.infinity,

      color: AppColors.grey50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Visibility(
                visible: !_getTaskStatusCountListnprogess,
                replacement: const CenterCircuerProgessIndicator(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskItems.length,
                  itemBuilder: (context, index) {
                    final item = taskItems[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      width: 190,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      // overall padding
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(8), // rounded corners
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: AppColors.whiteTranparent,
                            // optional background color
                            child: Icon(item['icon'], color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          // space between avatar and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // shrink column vertically
                            children: [
                              Text(
                                item['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item['count'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget _buildSummarySection() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Visibility(
      visible: _getTaskStatusCountListInProgress == false,
      replacement: const CenteredCircularProgressIndicator(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _getTaskSummaryCardList(),
        ),
      ),
    ),
  );
}

List<TaskSummaryCard> _getTaskSummaryCardList() {
  List<TaskSummaryCard> taskSummaryCardList = [];
  for (TaskStatusModel t in _taskStatusCountList) {
    taskSummaryCardList.add(TaskSummaryCard(title: t.sId!, count: t.sum ?? 0));
  }

  return taskSummaryCardList;
}*/
