import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/models/plan_week_day.dart';
import 'package:evencir_app/data/models/plan_workout_event.dart';
import 'package:evencir_app/gen/assets.gen.dart';
import 'package:evencir_app/presentation/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanWeekCalendarWidget extends StatefulWidget {
  const PlanWeekCalendarWidget({
    super.key,
    this.totalWeeks = 8,
    this.startDate,
  });

  final int totalWeeks;
  final DateTime? startDate;

  @override
  State<PlanWeekCalendarWidget> createState() => _PlanWeekCalendarWidgetState();
}

class _PlanWeekCalendarWidgetState extends State<PlanWeekCalendarWidget> {
  late final List<PlanWeekDay> _days;

  @override
  void initState() {
    super.initState();
    final startDate = widget.startDate ?? DateTime(2025, 12, 8);
    _days = List<PlanWeekDay>.generate(
      widget.totalWeeks * 7,
      (index) => PlanWeekDay(date: startDate.add(Duration(days: index))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        final planBloc = context.read<PlanBloc>();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Container(height: 1, color: AppColors.planCalendarDivider),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _days.length,
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: AppColors.planCalendarDivider,
                  ),
                  itemBuilder: (context, index) {
                    final day = _days[index];
                    final eventsForDay = state.workoutEvents
                        .where((event) => _isSameDay(event.day, day.date))
                        .toList(growable: false);

                    return DragTarget<PlanWorkoutEvent>(
                      onWillAcceptWithDetails: (details) =>
                          !_isSameDay(details.data.day, day.date),
                      onAcceptWithDetails: (details) {
                        planBloc.moveWorkoutEvent(
                          eventId: details.data.id,
                          newDay: day.date,
                        );
                      },
                      builder: (context, candidateData, rejectedData) {
                        final isActive = candidateData.isNotEmpty;

                        return Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              curve: Curves.easeOut,
                              color: isActive
                                  ? AppColors.planEventCardBackground
                                      .withValues(alpha: 0.15)
                                  : Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 54.w,
                                      child: _PlanDayLabel(
                                        day: day,
                                        hasEvent: eventsForDay.isNotEmpty,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: eventsForDay.isEmpty
                                          ? SizedBox(height: 66.h)
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (var i = 0;
                                                    i < eventsForDay.length;
                                                    i++) ...[
                                                  _PlanWorkoutEventCard(
                                                    event: eventsForDay[i],
                                                  ),
                                                  if (i !=
                                                      eventsForDay.length - 1)
                                                    SizedBox(height: 12.h),
                                                ],
                                              ],
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (index == _days.length - 1)
                              Container(
                                height: 1,
                                color: AppColors.planCalendarDivider,
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _PlanDayLabel extends StatelessWidget {
  const _PlanDayLabel({required this.day, required this.hasEvent});

  final PlanWeekDay day;
  final bool hasEvent;

  @override
  Widget build(BuildContext context) {
    final Color textColor = hasEvent
        ? AppColors.whiteColor
        : AppColors.unselectedTab;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _weekdayLabel(day.date.weekday),
          style: AppTextStyles.planCalendarWeekdayStyle.copyWith(
            color: textColor,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          '${day.date.day}',
          style: AppTextStyles.planCalendarDateStyle.copyWith(
            color: textColor,
            height: 1,
          ),
        ),
      ],
    );
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}

class _PlanWorkoutEventCard extends StatelessWidget {
  const _PlanWorkoutEventCard({required this.event});

  final PlanWorkoutEvent event;

  @override
  Widget build(BuildContext context) {
    final cardWidth =
        MediaQuery.of(context).size.width - 16.w * 2 - 54.w - 4.w;

    return Draggable<PlanWorkoutEvent>(
      data: event,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      rootOverlay: true,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(width: cardWidth, child: _buildCard(isDragging: true)),
      ),
      childWhenDragging: Opacity(opacity: 0.35, child: _buildCard()),
      child: _buildCard(),
    );
  }

  Widget _buildCard({bool isDragging = false}) {
    return Container(
      height: 78.h,
      decoration: BoxDecoration(
        color: AppColors.planEventCardBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: isDragging
            ? <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10.h, 14.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icons.threeDotsDouble.svg(
                        width: 22.w,
                        height: 22.w,
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.planEventBadgeBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.icons.legDay.svg(width: 10.w, height: 10.w),
                            SizedBox(width: 6.w),
                            Text(
                              event.badgeLabel,
                              style: AppTextStyles.planCalendarBadgeStyle
                                  .copyWith(
                                color: AppColors.planEventBadgeForeground,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.planCalendarEventTitleStyle
                              .copyWith(
                            color: AppColors.whiteColor,
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        event.durationLabel,
                        style: AppTextStyles.planCalendarDurationStyle.copyWith(
                          color: AppColors.whiteColor,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
