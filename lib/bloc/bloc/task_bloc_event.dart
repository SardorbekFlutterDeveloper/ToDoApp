part of 'task_bloc_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String username;
  const LoadTodosEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class AddTodosEvent extends TodosEvent {
  final String todoText;

  const AddTodosEvent(this.todoText);

  @override
  List<Object?> get props => [todoText];
}

class ToggleTodoState extends TodosEvent {
  final String todoTask;

  const ToggleTodoState(this.todoTask);
  
  @override

  List<Object?> get props => [todoTask];

}
