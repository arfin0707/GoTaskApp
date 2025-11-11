class TaskModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;

  TaskModel(
      {this.sId,
        this.title,
        this.description,
        this.status,
        this.email,
        this.createdDate});

  TaskModel.fromJson(Map<String, dynamic> json) {
    // sId = json['_id'];
    sId = json['id']?.toString() ?? json['_id']?.toString();
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
  }

/*  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? json['id']; // ✅ handles both
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
  }*/
}