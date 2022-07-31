import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todoapp/bloc/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login to Todo App"),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
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
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                      LoginEvent(usernameField.text, passwordField.text),
                    ),
                    child: Text("LOGIN "),
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
