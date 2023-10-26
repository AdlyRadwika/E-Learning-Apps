import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/user/user.dart';
import 'package:final_project/features/domain/usecases/user_cloud/get_user_by_id.dart';

part 'get_other_user_event.dart';
part 'get_other_user_state.dart';

class GetOtherUserBloc extends Bloc<GetOtherUserEvent, GetOtherUserState> {
  final GetUserByIdUseCase getOtherUserByIdUseCase;

  GetOtherUserBloc({
    required this.getOtherUserByIdUseCase,
  }) : super(GetOtherUserInitial()) {
    on<GetOtherUserByIdEvent>((event, emit) async {
      emit(GetOtherUserByIdLoading());

      final result = await getOtherUserByIdUseCase.execute(
        uid: event.uid,
      );

      emit(result.fold(
          (l) => GetOtherUserByIdResult(isSuccess: false, message: l.message),
          (r) => GetOtherUserByIdResult(isSuccess: true, user: r)));
    });
  }
}
