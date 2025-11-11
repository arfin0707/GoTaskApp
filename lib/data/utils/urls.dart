/*
class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  // static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  // static const String _baseUrl = 'http://10.0.2.2/task_manager_api';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static const String completedTaskList =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String taskStatusCount =
      '$_baseUrl/taskStatusCount';

  static const String cancelledTaskList =
      '$_baseUrl/listTaskByStatus/Cancelled';
  static const String inProgressTaskList =
      '$_baseUrl/listTaskByStatus/Progress';

  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask/$taskId';

  static const String profileUpdate = '$_baseUrl/profileUpdate';

  static String RecoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
}

*/

/*
class Urls {
  // Base URL for local API
  static const String _baseUrl = 'http://10.0.2.2/task_manager_api/api';

  // Auth
  static const String registration = '$_baseUrl/registration.php';
  static const String login = '$_baseUrl/login.php';

  // Tasks
  static const String createTask = '$_baseUrl/createTask.php';
  static const String newTaskList = '$_baseUrl/listTaskByStatus.php?status=New';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus.php?status=Completed';
  static const String cancelledTaskList = '$_baseUrl/listTaskByStatus.php?status=Cancelled';
  static const String inProgressTaskList = '$_baseUrl/listTaskByStatus.php?status=Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount.php';

  // Dynamic endpoints
  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus.php?taskId=$taskId&status=$status';

  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask.php?taskId=$taskId';

  // Profile (optional, if implemented)
  static const String profileUpdate = '$_baseUrl/profileUpdate.php';

  // Recover email (optional, if implemented)
  static String RecoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail.php?email=$email';
}

*/
/*
class Urls {
  // Base URL for local XAMPP/WAMP server
  static const String _baseUrl = 'http://10.0.2.2/task_manager_api/api';

  // Auth
  static const String registration = '$_baseUrl/registration.php';
  static const String login = '$_baseUrl/login.php';

  // Tasks
  static const String createTask = '$_baseUrl/createTask.php';
  static const String newTaskList = '$_baseUrl/listTaskByStatus.php?status=New';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus.php?status=Completed';
  static const String cancelledTaskList = '$_baseUrl/listTaskByStatus.php?status=Cancelled';
  static const String inProgressTaskList = '$_baseUrl/listTaskByStatus.php?status=Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount.php';

  // Dynamic endpoints
  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus.php?taskId=$taskId&status=$status';

  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask.php?taskId=$taskId';

  // Optional (future)
  static const String profileUpdate = '$_baseUrl/profileUpdate.php';
  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail.php?email=$email';
}
*/
class Urls {
  static const String _baseUrl = 'http://10.0.2.2/task_manager_api/api';

  // Auth
  static const String registration = '$_baseUrl/registration.php';
  static const String login = '$_baseUrl/login.php';

  // Tasks
  static const String createTask = '$_baseUrl/createTask.php';
  static const String newTaskList = '$_baseUrl/listTaskByStatus.php?status=New';
  static const String completedTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Completed';
  static const String cancelledTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Cancelled';
  static const String inProgressTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Progress';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount.php';

  // Dynamic endpoints
  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus.php?taskId=$taskId&status=$status';

  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask.php?taskId=$taskId';

  // Optional (future)
  static const String profileUpdate = '$_baseUrl/profileUpdate.php';
  // static String recoverVerifyEmail(String email) =>
  //     '$_baseUrl/RecoverVerifyEmail.php?email=$email';

  // Auth / Password reset
  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail.php?email=$email';
  static String recoverVerifyOTP(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOTP.php?email=$email&otp=$otp';
  static const String recoverResetPass = '$_baseUrl/RecoverResetPass.php';

}

/*
  API Endpoint Manager for Go Task App
  Backend: PHP + MySQL (task_manager_db)
  Tested with local server: http://10.0.2.2/task_manager_db
*/
/*

class Urls {
  // 🔗 Base URL (Android emulator localhost)
  static const String _baseUrl = 'http://10.0.2.2/task_manager_db';

  // 👤 Authentication
  static const String registration = '$_baseUrl/registration.php';
  static const String login = '$_baseUrl/login.php';

  // 👥 Profile
  static const String profileUpdate = '$_baseUrl/profileUpdate.php';



  // 🧾 Tasks CRUD
  static const String createTask = '$_baseUrl/createTask.php';

  // 📋 Task Lists by Status
  static const String newTaskList = '$_baseUrl/listTaskByStatus.php?status=New';
  static const String inProgressTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Progress';
  static const String completedTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Completed';
  static const String cancelledTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Cancelled';

  // 📊 Task Counters
  static const String taskStatusCount = '$_baseUrl/taskStatusCount.php';

  // 🔄 Change Task Status (GET params)
  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus.php?id=$taskId&status=$status';

  // ❌ Delete Task (GET param)
  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask.php?id=$taskId';

  // 🔐 Password Recovery APIs
  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail.php?email=$email';

  static String recoverVerifyOTP(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOTP.php?email=$email&otp=$otp';

  static const String recoverResetPass = '$_baseUrl/RecoverResetPass.php';
}
*/

/*
class Urls {
  // static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  // static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String _baseUrl = 'http://10.0.2.2/task_manager_db';
  static const String registration = '$_baseUrl/registration.php';
  static const String login = '$_baseUrl/login.php';
  static const String createTask = '$_baseUrl/createTask.php';

  // Task lists by status
  static const String newTaskList = '$_baseUrl/listTaskByStatus.php?status=New';
  static const String completedTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Completed';
  static const String cancelledTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Cancelled';
  static const String inProgressTaskList =
      '$_baseUrl/listTaskByStatus.php?status=Progress';

  // Task status count
  static const String taskStatusCount = '$_baseUrl/taskStatusCount.php';

  // Change task status (use query parameters)
  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus.php?id=$taskId&status=$status';

  // Delete task
  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask.php?id=$taskId';

  // Profile update
  static const String profileUpdate = '$_baseUrl/profileUpdate.php';

  // Password recovery
  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail.php?email=$email';
}

*/


/*
class Urls {
  // Base URL for your local PHP API
  // If using XAMPP, this should point to htdocs/task_manager_api/api/
  static const String _baseUrl = 'http://10.0.2.2/task_manager';

  // --- Authentication Endpoints ---
  static const String registration = '$_baseUrl/register.php';
  static const String login = '$_baseUrl/login.php';

  // --- Task Endpoints ---
  static const String createTask = '$_baseUrl/createTask.php';

  // For these, you'll append ?status=STATUS&email=EMAIL dynamically in code
  static const String newTaskList = '$_baseUrl/listTaskByStatus.php?status=New';
  static const String completedTaskList = '$_baseUrl/listTaskByStatus.php?status=Completed';
  static const String cancelledTaskList = '$_baseUrl/listTaskByStatus.php?status=Cancelled';
  static const String inProgressTaskList = '$_baseUrl/listTaskByStatus.php?status=Progress';

  // --- Status and Count ---
  static const String taskStatusCount = '$_baseUrl/taskStatusCount.php';

  // --- Update/Delete ---
*/
/*  static String changeStatus(String taskId, String status, String email) =>
      '$_baseUrl/updateTaskStatus.php?id=$taskId&status=$status&email=$email';

  static String deleteTask(String taskId, String email) =>
      '$_baseUrl/deleteTask.php?id=$taskId&email=$email';*//*

  static String changeStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus.php?id=$taskId&status=$status';

  static String deleteTask(String taskId) =>
      '$_baseUrl/deleteTask.php?id=$taskId';

  // --- Profile and Recovery (future use) ---
  static const String profileUpdate = '$_baseUrl/profileUpdate.php';
  static String recoverVerifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail.php?email=$email';

  // static String recoverVerifyEmail(String email) =>
  //     '$_baseUrl/RecoverVerifyEmail.php?email=$email';

  static String recoverVerifyOTP(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOTP.php?email=$email&otp=$otp';

  static const String recoverResetPass = '$_baseUrl/RecoverResetPass.php';

}
*/
