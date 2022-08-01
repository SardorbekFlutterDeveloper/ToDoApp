import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:todoapp/bloc/bloc/home_bloc.dart';
import 'package:todoapp/bloc/views/todo.dart';
import 'package:todoapp/service/authenticiation.dart';
import 'package:todoapp/service/task_service.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login to Todo App"),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(
            RegisterServiceEvent(),
          ),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginSatate) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodosPage(username: state.username),
                ),
              );
            }

            if (state is HomeInitial) {
              if (state.error != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Error"),
                    content: Text(state.error!),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Column(
                children: [
                  TextField(
                    controller: usernameField,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  TextField(
                    controller: passwordField,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              BlocProvider.of<HomeBloc>(context).add(
                            LoginEvent(usernameField.text, passwordField.text),
                          ),
                          child: const Text("LOGIN "),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(
                            RegisterAccountEvent(
                                usernameField.text, passwordField.text),
                          );
                        },
                        child: const Text("REGISTER"),
                      ),
                    ],
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
