import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/service/authenticiation.dart';
import 'package:todoapp/service/task_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServiceState()) {
    on<LoginEvent>(
      (event, emit) async {
        final user = await _auth.authenticeUser(event.username, event.password);

        if (user != null) {
          emit(SuccessfulLoginSatate(user));
          emit(const HomeInitial());
        }
      },
    );
    on<RegisterAccountEvent>(
      (event, emit) async {
        final result = await _auth.createUser(event.username, event.password);

        switch (result) {
          case UserCreationResult.success:
            emit(SuccessfulLoginSatate(event.username));
            break;
          case UserCreationResult.failure:
            emit(
              const HomeInitial(error: "There's been an error"),
            );
            break;
          case UserCreationResult.alerady_exists:
            emit(const HomeInitial(error: "User already exists"));

            break;
        }
      },
    );

    on<RegisterServiceEvent>(
      (event, emit) async {
        await _auth.init();

        await _todo.init();

        emit(HomeInitial());
      },
    );
  }
}
