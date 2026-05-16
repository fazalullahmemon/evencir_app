import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/models/calorie_insight_data.dart';
import 'package:evencir_app/data/models/hydration_log_data.dart';
import 'package:evencir_app/data/models/weight_insight_data.dart';
import 'package:evencir_app/gen/assets.gen.dart';
import 'package:evencir_app/presentation/bloc/plan_bloc.dart';
import 'package:evencir_app/presentation/widgets/calorie_insight_widget.dart';
import 'package:evencir_app/presentation/widgets/hydration_log_widget.dart';
import 'package:evencir_app/presentation/widgets/workout_calendar_entry_card.dart';
import 'package:evencir_app/presentation/widgets/weight_insight_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  static const CalorieInsightData _calorieInsight = CalorieInsightData(
    caloriesBurned: 550,
    caloriesRemaining: 1950,
    totalCalories: 2500,
  );

  static const WeightInsightData _weightInsight = WeightInsightData(
    currentWeight: 75,
    upwardTrendWeight: 1.6,
  );

  static const HydrationLogData _hydrationLog = HydrationLogData(
    currentMl: 0,
    goalMl: 2000,
    addedMl: 500,
  );

  bool get _isDaytime {
    final hour = DateTime.now().hour;
    return hour >= 6 && hour < 18;
  }

  SvgGenImage get _weatherIcon =>
      _isDaytime ? Assets.icons.sun : Assets.icons.moon;

  String _monthLabel(DateTime day) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${day.day} ${months[day.month - 1]} ${day.year}';
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final planBloc = context.read<PlanBloc>();
    planBloc.selectNutritionDay(selectedDay);
    planBloc.focusNutritionDay(selectedDay);
  }

  void _openFullCalendarBottomSheet() {
    final planBloc = context.read<PlanBloc>();
    final initialSelectedDay = planBloc.state.nutritionSelectedDay;
    final initialFocusedDay = planBloc.state.nutritionFocusedDay;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        DateTime focusedDay = initialFocusedDay;
        DateTime selectedDay = initialSelectedDay;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 4),

                      Container(
                        width: 90,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        IconButton(
                          onPressed: () {
                            setModalState(() {
                              focusedDay = DateTime(
                                focusedDay.year,
                                focusedDay.month - 1,
                                1,
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            color: AppColors.whiteColor,
                              size: 30,
                            ),
                          ),
                          Text(
                            _monthYearLabel(focusedDay),
                            style: AppTextStyles.calendarMonthStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          IconButton(
                          onPressed: () {
                            setModalState(() {
                              focusedDay = DateTime(
                                focusedDay.year,
                                focusedDay.month + 1,
                                1,
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            color: AppColors.whiteColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TableCalendar<void>(
                        firstDay: DateTime.utc(2010, 1, 1),
                        lastDay: DateTime.utc(2035, 12, 31),
                        focusedDay: focusedDay,
                        calendarFormat: CalendarFormat.month,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month',
                        },
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerVisible: false,
                        daysOfWeekVisible: true,
                        sixWeekMonthsEnforced: false,
                        rowHeight: 54,
                        daysOfWeekHeight: 36,
                        selectedDayPredicate: (day) =>
                            isSameDay(selectedDay, day),
                        onDaySelected: (day, newFocusedDay) {
                          setModalState(() {
                            selectedDay = day;
                            focusedDay = newFocusedDay;
                          });
                          planBloc.selectNutritionDay(day);
                          planBloc.focusNutritionDay(day);
                        },
                        onPageChanged: (newFocusedDay) {
                          setModalState(() {
                            focusedDay = newFocusedDay;
                          });
                        },
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: false,
                          outsideDaysVisible: false,
                          defaultTextStyle:
                              AppTextStyles.calendarDayDateStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                          weekendTextStyle:
                              AppTextStyles.calendarDayDateStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                          selectedTextStyle:
                              AppTextStyles.calendarDayDateStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                          todayTextStyle:
                              AppTextStyles.calendarDayDateStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                          cellMargin: const EdgeInsets.symmetric(vertical: 6),
                          cellPadding: EdgeInsets.zero,
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF25C36E),
                              width: 3,
                            ),
                          ),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.dayBackground,
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle:
                              AppTextStyles.calendarDayNameStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                          weekendStyle:
                              AppTextStyles.calendarDayNameStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w700,
                          ),
                          dowTextFormatter: (day, locale) {
                            const labels = <String>[
                              'MON',
                              'TUE',
                              'WED',
                              'THU',
                              'FRI',
                              'SAT',
                              'SUN',
                            ];
                            return labels[day.weekday - 1];
                          },
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            final isSelected = isSameDay(selectedDay, day);
                            return _MonthDayCell(
                              day: day.day.toString(),
                              selected: isSelected,
                            );
                          },
                          todayBuilder: (context, day, focusedDay) {
                            final isSelected = isSameDay(selectedDay, day);
                            return _MonthDayCell(
                              day: day.day.toString(),
                              selected: isSelected,
                            );
                          },
                          selectedBuilder: (context, day, focusedDay) {
                            return _MonthDayCell(
                              day: day.day.toString(),
                              selected: true,
                            );
                          },
                          dowBuilder: (context, day) {
                            const labels = <String>[
                              'MON',
                              'TUE',
                              'WED',
                              'THU',
                              'FRI',
                              'SAT',
                              'SUN',
                            ];
                            final label = labels[day.weekday - 1];
                            return Center(
                              child: Text(
                                label,
                                style: AppTextStyles.calendarDayNameStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _monthYearLabel(DateTime day) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[day.month - 1]} ${day.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        final planBloc = context.read<PlanBloc>();
        final selectedDay = state.nutritionSelectedDay;
        final today = DateTime.now();
        final headerText = isSameDay(selectedDay, today)
            ? 'Today, ${_monthLabel(selectedDay)}'
            : _monthLabel(selectedDay);
        final workoutEntries = state.workoutEvents
            .where((event) => isSameDay(event.day, selectedDay))
            .toList(growable: false);

        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            backgroundColor: AppColors.pageBackground,
            elevation: 0,
            centerTitle: true,
            leadingWidth: 56,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Center(
                child: Assets.icons.bell.svg(
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.icons.weekIcon.svg(
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _openFullCalendarBottomSheet,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.nutritionWeekLabel,
                        style: AppTextStyles.weekIndicatorStyle.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Assets.icons.arrowDown.svg(
                        width: 6,
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              headerText,
                              style: AppTextStyles.dateIndicatorStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TableCalendar<void>(
                            firstDay: DateTime.utc(2010, 1, 1),
                            lastDay: DateTime.utc(2035, 12, 31),
                            focusedDay: state.nutritionFocusedDay,
                            calendarFormat: CalendarFormat.week,
                            availableCalendarFormats: const {
                              CalendarFormat.week: 'Week',
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            headerVisible: false,
                            daysOfWeekVisible: true,
                            sixWeekMonthsEnforced: false,
                            rowHeight: 60,
                            daysOfWeekHeight: 28,
                            selectedDayPredicate: (day) =>
                                isSameDay(selectedDay, day),
                            onDaySelected: _onDaySelected,
                            onPageChanged: (focusedDay) {
                              context
                                  .read<PlanBloc>()
                                  .focusNutritionDay(focusedDay);
                            },
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: false,
                              outsideDaysVisible: false,
                              defaultTextStyle:
                                  AppTextStyles.calendarDayDateStyle.copyWith(
                                color: AppColors.mutedText,
                              ),
                              weekendTextStyle:
                                  AppTextStyles.calendarDayDateStyle.copyWith(
                                color: AppColors.mutedText,
                              ),
                              selectedTextStyle:
                                  AppTextStyles.calendarDayDateStyle.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w700,
                              ),
                              todayTextStyle:
                                  AppTextStyles.calendarDayDateStyle.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w700,
                              ),
                              cellMargin:
                                  const EdgeInsets.symmetric(vertical: 6),
                              cellPadding: EdgeInsets.zero,
                              selectedDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.selectedBorder,
                                  width: 2,
                                ),
                              ),
                              todayDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dayBackground,
                              ),
                              defaultDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dayBackground,
                              ),
                              weekendDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dayBackground,
                              ),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle:
                                  AppTextStyles.calendarDayNameStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                              weekendStyle:
                                  AppTextStyles.calendarDayNameStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                              dowTextFormatter: (day, locale) {
                                const labels = <String>[
                                  'M',
                                  'TU',
                                  'W',
                                  'TH',
                                  'F',
                                  'SA',
                                  'SU',
                                ];
                                return labels[day.weekday - 1];
                              },
                            ),
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                                final isSelected = isSameDay(day, selectedDay);
                                return _DayCell(
                                  day: day.day.toString(),
                                  backgroundColor: AppColors.dayBackground,
                                  selected: isSelected,
                                  textColor: AppColors.whiteColor,
                                  selectedBorderColor: AppColors.selectedBorder,
                                  hasWorkout: planBloc.hasWorkoutOn(day),
                                );
                              },
                              todayBuilder: (context, day, focusedDay) {
                                final isSelected = isSameDay(day, selectedDay);
                                return _DayCell(
                                  day: day.day.toString(),
                                  backgroundColor: AppColors.dayBackground,
                                  selected: isSelected,
                                  textColor: AppColors.whiteColor,
                                  selectedBorderColor: AppColors.selectedBorder,
                                  hasWorkout: planBloc.hasWorkoutOn(day),
                                );
                              },
                              selectedBuilder: (context, day, focusedDay) {
                                return _DayCell(
                                  day: day.day.toString(),
                                  backgroundColor: AppColors.dayBackground,
                                  selected: true,
                                  textColor: AppColors.whiteColor,
                                  selectedBorderColor: AppColors.selectedBorder,
                                  hasWorkout: planBloc.hasWorkoutOn(day),
                                );
                              },
                              dowBuilder: (context, day) {
                                const labels = <String>[
                                  'M',
                                  'TU',
                                  'W',
                                  'TH',
                                  'F',
                                  'SA',
                                  'SU',
                                ];
                                final label = labels[day.weekday - 1];
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      label,
                                      style: AppTextStyles.calendarDayNameStyle
                                          .copyWith(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Container(
                              width: 52,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.dayBackground,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Workouts',
                              style: AppTextStyles.heading.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _weatherIcon.svg(
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '9°',
                                  style: AppTextStyles.temperatureStyle.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (workoutEntries.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'No workouts scheduled.',
                              style:
                                  AppTextStyles.planWeekSubtitleStyle.copyWith(
                                color: AppColors.mutedText,
                              ),
                            ),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: workoutEntries.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return WorkoutCalendarEntryCard(
                                event: workoutEntries[index],
                              );
                            },
                          ),
                        const SizedBox(height: 24),
                        Text(
                          'Insights',
                          style: AppTextStyles.heading.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CalorieInsightWidget(
                                data: _calorieInsight,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: WeightInsightWidget(data: _weightInsight),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        HydrationLogWidget(data: _hydrationLog),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MonthDayCell extends StatelessWidget {
  const _MonthDayCell({
    required this.day,
    required this.selected,
  });

  final String day;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: selected
            ? Border.all(color: const Color(0xFF25C36E), width: 3)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        day,
        style: AppTextStyles.calendarDayDateStyle.copyWith(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.backgroundColor,
    required this.selected,
    required this.textColor,
    required this.selectedBorderColor,
    required this.hasWorkout,
  });

  final String day;
  final Color backgroundColor;
  final bool selected;
  final Color textColor;
  final Color selectedBorderColor;
  final bool hasWorkout;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: selected
                ? Border.all(color: selectedBorderColor, width: 2)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            day,
            style: AppTextStyles.calendarDayDateStyle.copyWith(
              color: selected ? AppColors.whiteColor : textColor,
            ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 8,
          child: hasWorkout
              ? Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.selectedBorder,
                    shape: BoxShape.circle,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
