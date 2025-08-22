class TodoModel {
  final String? id;
  final String name;

  TodoModel({this.id, required this.name});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(id: json['id'] ?? '0', name: json['name']);
  }
}
