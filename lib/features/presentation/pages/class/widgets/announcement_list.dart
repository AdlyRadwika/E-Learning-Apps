import 'package:final_project/features/presentation/bloc/announcement_cloud/get_announcement/get_announcements_bloc.dart';
import 'package:final_project/features/presentation/pages/class/widgets/announcement_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnnouncementListWidget extends StatelessWidget {
  final bool shouldLimit;

  const AnnouncementListWidget({
    super.key,
    required this.shouldLimit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAnnouncementsBloc, GetAnnouncementsState>(
        builder: (context, state) {
      if (state is GetAnnouncementsByClassLoading) {
        return const SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
      if (state is GetAnnouncementsByClassResult && state.isSuccess) {
        final announcements = state.announcements;
        if (announcements?.isEmpty == true) {
          return const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text("There is no announcements yet."),
              ),
            ),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: shouldLimit
                  ? announcements?.length.clamp(0, 1)
                  : announcements?.length,
              itemBuilder: (context, index) {
                final data = announcements?[index];
                return AnnoucementItem(
                  data: data,
                );
              }),
        );
      }
      if (state is GetAnnouncementsByClassResult && !state.isSuccess) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: 1,
              itemBuilder: (context, index) {
                return const AnnoucementItem(
                  data: null,
                );
              }),
        );
      }
      return const SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 10),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: Text("There is no announcements yet."),
          ),
        ),
      );
    });
  }
}
