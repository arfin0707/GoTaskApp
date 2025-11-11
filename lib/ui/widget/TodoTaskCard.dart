import 'package:flutter/material.dart';
import 'package:task_manager_app_go_task/data/models/network_response.dart';
import 'package:task_manager_app_go_task/data/models/task_model.dart';
import 'package:task_manager_app_go_task/data/services/network_caller.dart';
import 'package:task_manager_app_go_task/data/utils/urls.dart';
import 'package:task_manager_app_go_task/ui/utils/app_colors.dart';
import 'package:task_manager_app_go_task/ui/widget/center_circuer_progess_indicator.dart';
import 'package:task_manager_app_go_task/ui/widget/snack_bar_message.dart';

class TodoTaskCard extends StatefulWidget {
  const TodoTaskCard({
    super.key,
    required this.taskModel,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TodoTaskCard> createState() => _TodoTaskCardState();
}

class _TodoTaskCardState extends State<TodoTaskCard> {
  String _selectedStatus = '';
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.white,
      shadowColor: AppColors.black_12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.taskModel.description ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:AppColors.grey800,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.taskModel.createdDate ?? '',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.grey800),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // _buildTaskChip(),
                _buildTaskChip(context),
                Wrap(
                  spacing: 4,
                  children: [
                    Visibility(
                      visible: _changeStatusInProgress == false,
                      replacement: CenterCircuerProgessIndicator(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _onTapEditButton();
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: AppColors.primary,
                          ),
                          tooltip: "Edit Task",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _deleteTaskInProgress == false,
                      replacement: CenterCircuerProgessIndicator(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.dangerLight.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _onTapDeleteButton();
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.dangerLight,
                          ),
                          tooltip: "Delete Task",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Edit Status',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
              //Converts the result of map() into a list of widgets.
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: _selectedStatus == e
                    ? AppColors.primary.withOpacity(0.1)
                    : null,
                onTap: () {
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(
                  e,
                  style: TextStyle(
                    fontWeight: _selectedStatus == e
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _selectedStatus == e
                        ? AppColors.primary
                        : AppColors.black_soft,
                  ),
                ),
                selected: _selectedStatus == e,
                trailing: _selectedStatus == e
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color:  AppColors.primary)),
            ),
            /*
            TextButton(onPressed: () {}, child: Text('Okay')),
*/
          ],
        );
      },
    );
  }

/*  Widget _buildTaskChip() {
    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.primary),
      ),
    );
  }*/
  /// --- Task Status Chip ---
  Widget _buildTaskChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color background;
    Color textColor;

    switch (widget.taskModel.status) {
      case 'Completed':
        background =AppColors.green_shade50 ;
        textColor = AppColors.green_shade700;
        break;
      case 'Progress':
        background = AppColors.orange_shade50;
        textColor = AppColors.orange_shade700;
        break;
      case 'Cancelled':
        background = AppColors.redShade50;
        textColor = AppColors.dangerLight;
        break;
      default:
        background = colorScheme.primaryContainer.withOpacity(0.2);
        textColor = colorScheme.primary;
    }

    return Chip(
      label: Text(
        widget.taskModel.status!,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      backgroundColor: background,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      side: BorderSide(color: textColor.withOpacity(0.3)),
    );
  }

  void _onTapDeleteButton() {
    final theme = Theme.of(context);
    // final cs = theme.colorScheme;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color:  AppColors.dangerLight, size: 26),
            const SizedBox(width: 8),
            Text('Delete Task?',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color:  AppColors.dangerLight,
                )),
          ],
        ),
        content: Text(
          'Are you sure you want to permanently delete this task?.',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color:  AppColors.black_soft.withOpacity(0.8), height: 1.5),
        ),
        actions: [
          Wrap(
            spacing: 4,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor:  AppColors.primary,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _deleteTaskInProgress
                    ? null
                    : () async {
                  Navigator.pop(context);
                  await _confirmDeleteTask();
                },
                style: TextButton.styleFrom(
                  foregroundColor:  AppColors.dangerLight,
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                  overlayColor: AppColors.dangerLight.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(_deleteTaskInProgress ? 'Deleting...' : 'Delete'),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteTask() async {
    _deleteTaskInProgress = true;
    setState(() {});
/*    final res =
    await NetworkCaller.getRequest(url: Urls.deleteTask(widget.taskModel.sId!));*/
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }
  /*  void _onTapDeleteButton() async {
    _deleteTaskInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTask(widget.taskModel.sId!),
    );

    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }*/



  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.changeStatus(widget.taskModel.sId!, newStatus),
    );

    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }

/*  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.changeStatus(widget.taskModel.sId!, newStatus),
    );

    if (response.isSuccess) {
      // update local status immediately
      setState(() {
        _selectedStatus = newStatus;
        _changeStatusInProgress = false;  // hide progress indicator
      });

      // refresh list if needed
      widget.onRefreshList();
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackbarMessage(context, response.errorMessage, true);
    }
  }*/

}
