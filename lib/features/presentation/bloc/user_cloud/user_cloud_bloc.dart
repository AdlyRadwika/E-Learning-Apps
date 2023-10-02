import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/domain/usecases/user_cloud/get_user_by_id.dart';
import 'package:final_project/features/domain/usecases/user_cloud/insert_user_data.dart';

part 'user_cloud_event.dart';
part 'user_cloud_state.dart';

class UserCloudBloc extends Bloc<UserCloudEvent, UserCloudState> {
  final InsertUserDataUseCase insertUserDataUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  UserCloudBloc({
    required this.insertUserDataUseCase,
    required this.getUserByIdUseCase,
  }) : super(UserCloudInitial()) {
    on<InsertUserEvent>((event, emit) async {
      emit(InsertUserLoading());

      final result = await insertUserDataUseCase.execute(
        uid: event.uid,
        email: event.email,
        userName: event.userName,
        role: event.role,
        imageData: event.imageData,
        imageUrl: event.imageUrl,
      );

      emit(result.fold(
          (l) => InsertUserResult(isSuccess: false, message: l.message),
          (r) => InsertUserResult(isSuccess: true)));
    });
    on<GetUserByIdEvent>((event, emit) async {
      emit(GetUserByIdLoading());

      final result = await getUserByIdUseCase.execute(
        uid: event.uid,
      );

      emit(result.fold(
          (l) => GetUserByIdResult(isSuccess: false, message: l.message),
          (r) => GetUserByIdResult(isSuccess: true, user: r)));
    });
  }
}
