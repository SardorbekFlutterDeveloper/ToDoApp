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
  TodoLoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}
