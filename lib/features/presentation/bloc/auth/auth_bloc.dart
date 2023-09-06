import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/usecases/auth/login.dart';
import 'package:final_project/features/domain/usecases/auth/logout.dart';
import 'package:final_project/features/domain/usecases/auth/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());

      final result = await loginUseCase.execute(
          email: event.email, password: event.password);

      emit(result.fold((l) => LoginResult(isSuccess: false, message: l.message),
          (r) => LoginResult(isSuccess: true)));
    });
    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());

      final result = await registerUseCase.execute(
          email: event.email, password: event.password);

      emit(result.fold(
          (l) => RegisterResult(isSuccess: false, message: l.message),
          (r) => RegisterResult(isSuccess: true)));
    });
    on<LogoutEvent>((event, emit) async {
      final result = await logoutUseCase.execute();

      emit(result.fold(
          (l) => LogoutResult(isSuccess: false, message: l.message),
          (r) => LogoutResult(isSuccess: true)));
    });
  }
}