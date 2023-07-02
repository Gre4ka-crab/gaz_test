import 'package:bloc/bloc.dart';
import 'package:gaz_test/domain/use_cases/sig_in_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LogInUseCase logInUseCase;

  AuthCubit({required this.logInUseCase}) : super(AuthInitial());

  Future<void> logIn({required String email, required String password}) async {
    emit(AuthLoading());

    var result = await logInUseCase(ParamsLogIn(email: email, password: password));
    result.fold(
      (error) => emit(AuthError(message: error.toString())),
      (result) => emit(AuthLoaded(true)),
    );
  }
}
