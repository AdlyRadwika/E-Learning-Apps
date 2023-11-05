import 'package:calendar_view/calendar_view.dart';
import 'package:final_project/common/util/date_util.dart';
import 'package:final_project/common/util/user_config.dart';
import 'package:final_project/features/domain/entities/assignment/assignment.dart';
import 'package:final_project/features/presentation/bloc/assignment_cloud/get_assignment_schedule/get_assignment_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({
    super.key,
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  void _getData() {
    final uid = UserConfigUtil.uid;
    context.read<GetScheduleBloc>().add(UserConfigUtil.role == 'teacher'
        ? GetTeacherScheduleEvent(teacherId: uid)
        : GetAssignmentsSchedulesEvent(studentId: uid));
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  List<CalendarEventData<Assignment>> buildCalendarEvents(
      List<Assignment> data) {
    return data.map((assignment) {
      return CalendarEventData<Assignment>(
        title: assignment.title,
        date: DateTime.tryParse(assignment.deadline) ?? DateTime.now(),
        startTime: DateTime.tryParse(assignment.createdAt) ?? DateTime.now(),
        endTime: DateTime.tryParse(assignment.createdAt) ?? DateTime.now(),
        description: assignment.description,
      );
    }).toList();
  }

  void _onEventDialog(CalendarEventData<Assignment> event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event.title),
          content: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(event.description),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Deadline",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(DateUtil.formatDate(event.endDate.toString())),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Confirm'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<GetScheduleBloc, GetScheduleState>(
      builder: (context, state) {
        if (state is GetScheduleLoading) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }

        if (state is GetTeacherScheduleResult && state.isSuccess) {
          final data = state.assignments;

          if (data == null || data.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('The assignments data is empty.'),
              ),
            );
          }

          final events = buildCalendarEvents(data);

          return SliverFillRemaining(
            child: CalendarControllerProvider<Assignment>(
              controller: EventController<Assignment>()..addAll(events),
              child: MonthView<Assignment>(
                headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer),
                    headerTextStyle: TextStyle(
                        color: theme.colorScheme.onSecondaryContainer)),
                borderColor: theme.colorScheme.onSurface,
                onEventTap: (event, date) {
                  _onEventDialog(event);
                },
              ),
            ),
          );
        }

        if (state is GetTeacherScheduleResult && !state.isSuccess) {
          return SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                ElevatedButton(
                  onPressed: () => _getData(),
                  child: const Text('Try Again'),
                )
              ],
            ),
          );
        }

        if (state is GetAssignmentsSchedulesResult && state.isSuccess) {
          final data = state.assignments;

          if (data == null || data.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('The assignments data is empty.'),
              ),
            );
          }

          final events = buildCalendarEvents(data);

          return SliverFillRemaining(
            child: CalendarControllerProvider<Assignment>(
              controller: EventController<Assignment>()..addAll(events),
              child: MonthView<Assignment>(
                headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer),
                    headerTextStyle: TextStyle(
                        color: theme.colorScheme.onSecondaryContainer)),
                borderColor: theme.colorScheme.onSurface,
                onEventTap: (event, date) {
                  _onEventDialog(event);
                },
              ),
            ),
          );
        }

        if (state is GetAssignmentsSchedulesResult && !state.isSuccess) {
          return SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                ElevatedButton(
                  onPressed: () => _getData(),
                  child: const Text('Try Again'),
                )
              ],
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something went wrong."),
              ElevatedButton(
                onPressed: () => _getData(),
                child: const Text('Try Again'),
              )
            ],
          ),
        );
      },
    );
  }
}
