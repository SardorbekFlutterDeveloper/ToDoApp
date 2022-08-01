import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/task.dart';
import '../../service/task_service.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.username);
      emit(TodoLoadedState(todos, event.username));
    });
    on<AddTodosEvent>((event, emit) {
      final currentState = state as TodoLoadedState;
      _todoService.addTasks(event.todoText, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<ToggleTodoState>(
      (event, emit) async {
        final currentState = state as TodoLoadedState;

        await _todoService.updateTask(event.todoTask, currentState.username);
        add(LoadTodosEvent(currentState.username));
      },
    );
  }
}
