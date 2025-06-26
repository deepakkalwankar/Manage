import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/task_model.dart';

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  AddTask(this.title);
}

class ToggleTask extends TaskEvent {
  final int index;
  ToggleTask(this.index);
}

class DeleteTask extends TaskEvent {
  final int index;
  DeleteTask(this.index);
}

class LoadTasks extends TaskEvent {}

class TaskBloc extends Bloc<TaskEvent, List<TaskModel>> {
  final SharedPreferences prefs;

  TaskBloc(this.prefs) : super([]) {
    on<LoadTasks>((event, emit) => emit(_loadFromPrefs()));
    on<AddTask>((event, emit) {
      final updated = [...state, TaskModel(title: event.title)];
      _saveToPrefs(updated);
      emit(updated);
    });
    on<ToggleTask>((event, emit) {
      final updated = [...state];
      updated[event.index].isCompleted = !updated[event.index].isCompleted;
      _saveToPrefs(updated);
      emit(updated);
    });
    on<DeleteTask>((event, emit) {
      final updated = [...state]..removeAt(event.index);
      _saveToPrefs(updated);
      emit(updated);
    });
  }

  List<TaskModel> _loadFromPrefs() {
    final data = prefs.getStringList('tasks') ?? [];
    print("📦 Loaded from prefs: $data");
    return data.map((e) => TaskModel.fromJson(json.decode(e))).toList();
  }

  void _saveToPrefs(List<TaskModel> tasks) {
    final data = tasks.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList('tasks', data);
    print("🔐 Saved to prefs: $data");
  }
}
