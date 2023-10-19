import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/get_announcements_by_class.dart';

part 'get_announcements_event.dart';
part 'get_announcements_state.dart';

class GetAnnouncementsBloc
    extends Bloc<GetAnnouncementsEvent, GetAnnouncementsState> {
  final GetAnnouncementsByClassUseCase getAnnouncementsUseCase;

  GetAnnouncementsBloc({
    required this.getAnnouncementsUseCase,
  }) : super(GetAnnouncementsInitial()) {
    on<GetAnnouncementsByClassEvent>((event, emit) async {
      emit(GetAnnouncementsByClassLoading());

      final result = await getAnnouncementsUseCase.execute(classCode: event.classCode);

      emit(result.fold(
          (l) =>
              GetAnnouncementsByClassResult(isSuccess: false, message: l.message),
          (r) =>
              GetAnnouncementsByClassResult(isSuccess: true, announcements: r)));
    });
  }
}
