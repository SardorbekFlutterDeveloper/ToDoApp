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

                  ...state.tasks
                    .map(
                      (e) => ListTile(
                        title: Text(e.task),
                        trailing: Checkbox(
                          value: e.iscomplated,
                          onChanged: (val) {},
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("Create new task"),
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
