import 'package:bloc/bloc.dart';
import 'package:final_project/features/domain/entities/announcement/announcement_content.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/delete_announcement.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/get_announcements_by_uid.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/insert_announcement.dart';
import 'package:final_project/features/domain/usecases/announcement_cloud/update_announcement.dart';

part 'announcement_cloud_event.dart';
part 'announcement_cloud_state.dart';

class AnnouncementCloudBloc
    extends Bloc<AnnouncementCloudEvent, AnnouncementCloudState> {
  final InsertAnnouncementUseCase insertUseCase;
  final DeleteAnnouncementUseCase deleteUseCase;
  final UpdateAnnouncementUseCase updateUseCase;
  final GetAnnouncementsByUidUseCase getAnnouncementsUseCase;

  AnnouncementCloudBloc({
    required this.insertUseCase,
    required this.deleteUseCase,
    required this.updateUseCase,
    required this.getAnnouncementsUseCase,
  }) : super(AnnouncementCloudInitial()) {
    on<InsertAnnouncementEvent>((event, emit) async {
      emit(InsertAnnouncementLoading());

      final result = await insertUseCase.execute(
          announcementId: event.announcementId,
          teacherId: event.teacherId,
          content: event.content,
          classCode: event.classCode);

      emit(result.fold(
          (l) => InsertAnnouncementResult(isSuccess: false, message: l.message),
          (r) => InsertAnnouncementResult(isSuccess: true)));
    });
    on<DeleteAnnouncementEvent>((event, emit) async {
      emit(DeleteAnnouncementLoading());

      final result = await deleteUseCase.execute(announcementId: event.id);

      emit(result.fold(
          (l) => DeleteAnnouncementResult(isSuccess: false, message: l.message),
          (r) => DeleteAnnouncementResult(isSuccess: true)));
    });
    on<UpdateAnnouncementEvent>((event, emit) async {
      emit(UpdateAnnouncementLoading());

      final result = await updateUseCase.execute(
          announcementId: event.id, content: event.content);

      emit(result.fold(
          (l) => UpdateAnnouncementResult(isSuccess: false, message: l.message),
          (r) => UpdateAnnouncementResult(isSuccess: true)));
    });
    on<GetAnnouncementsByUidEvent>((event, emit) async {
      emit(GetAnnouncementsByUidLoading());

      final result = await getAnnouncementsUseCase.execute(uid: event.uid);

      emit(result.fold(
          (l) =>
              GetAnnouncementsByUidResult(isSuccess: false, message: l.message),
          (r) =>
              GetAnnouncementsByUidResult(isSuccess: true, announcements: r)));
    });
  }
}
