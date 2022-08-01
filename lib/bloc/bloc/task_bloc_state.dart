part of 'task_bloc_bloc.dart';

@immutable
abstract class TodosState extends Equatable {
  const TodosState();
}

class TodosInitial extends TodosState {
  @override
  List<Object?> get props => [];
}

class TodoLoadedState extends TodosState {
  final List<Task> tasks;
  final String username;

  const TodoLoadedState(this.tasks, this.username);

  @override
  List<Object?> get props => [tasks,username];
}
