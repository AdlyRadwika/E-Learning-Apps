import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/usecases/user_store/insert_user_data.dart';

part 'user_store_event.dart';
part 'user_store_state.dart';

class UserStoreBloc extends Bloc<UserStoreEvent, UserStoreState> {
  final InsertUserDataUseCase insertUserDataUseCase;

  UserStoreBloc({
    required this.insertUserDataUseCase,
  }) : super(UserStoreInitial()) {
    on<InsertUserEvent>((event, emit) async {
      emit(InsertUserLoading());

      final result = await insertUserDataUseCase.execute(
          uid: event.uid,
          email: event.email,
          userName: event.userName,
          role: event.role);

      emit(result.fold(
          (l) => InsertUserResult(isSuccess: false, message: l.message),
          (r) => InsertUserResult(isSuccess: true)));
    });
  }
}
