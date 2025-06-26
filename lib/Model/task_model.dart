class TaskModel {
  String title;
  bool isCompleted;

  TaskModel({required this.title, this.isCompleted = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'isCompleted': isCompleted,
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json['title'],
        isCompleted: json['isCompleted'],
      );
}
