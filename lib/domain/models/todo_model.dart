// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoModel {
  final String id;
  final String name;
  final String description;
  final bool done;

  TodoModel({required this.id, required this.name, required this.description, required this.done});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? '0',
      name: json['name'],
      description: json['description'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'done': done};
  }

  TodoModel copyWith({String? id, String? name, String? description, bool? done}) {
    return TodoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }
}
