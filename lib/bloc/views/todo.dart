import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/bloc/task_bloc_bloc.dart';
import 'package:todoapp/service/task_service.dart';

class TodosPage extends StatelessWidget {
  final String username;
  const TodosPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
      ),
      body: BlocProvider(
        create: (context) => TodosBloc(
          RepositoryProvider.of<TodoService>(context),
        )..add(
            LoadTodosEvent(username),
          ),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodoLoadedState) {
              return ListView(
                children: [
                  ...state.tasks.map(
                    (e) => ListTile(
                      title: Text(e.task),
                      trailing: Checkbox(
                        value: e.iscomplated,
                        onChanged: (val) {
                          BlocProvider.of<TodosBloc>(context).add(
                            ToggleTodoState(e.task),
                          );
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Create new task"),
                    trailing: const Icon(Icons.create),
                    onTap: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) => const Dialog(
                          child: CreateNewTask(),
                        ),
                      );
                      if (result != null) {
                        BlocProvider.of<TodosBloc>(context)
                            .add(AddTodosEvent(result));
                      }
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(" What task do you want to create"),
        TextField(
          controller: _inputController,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_inputController.text);
          },
          child: const Text("SAVE"),
        ),
      ],
    );
  }
}
