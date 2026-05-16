import 'dart:async';

import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/repositories/plan_workout_repository_impl.dart';
import 'package:evencir_app/domain/usecases/load_plan_workout_events_usecase.dart';
import 'package:evencir_app/gen/assets.gen.dart';
import 'package:evencir_app/presentation/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mood_screen.dart';
import 'nutrition_screen.dart';
import 'plan_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final PlanBloc _planBloc;
  late final List<Widget> _screens;

  static final List<SvgGenImage> _navigationIcons = <SvgGenImage>[
    Assets.icons.nutrition,
    Assets.icons.plan,
    Assets.icons.mood,
    Assets.icons.profile,
  ];

  static const List<String> _navigationLabels = <String>[
    'Nutrition',
    'Plan',
    'Mood',
    'Profile',
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _planBloc = PlanBloc(
      loadPlanWorkoutEventsUseCase: LoadPlanWorkoutEventsUseCase(
        const PlanWorkoutRepositoryImpl(),
      ),
    );
    _screens = <Widget>[
      const NutritionScreen(),
      const PlanScreen(),
      const MoodScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    unawaited(_planBloc.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    final navigationItems = List<BottomNavigationBarItem>.generate(
      _navigationIcons.length,
      (index) => BottomNavigationBarItem(
        icon: _navigationIcons[index].svg(
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            index == _selectedIndex ? AppColors.whiteColor : AppColors.unselectedTab,
            BlendMode.srcIn,
          ),
        ),
        label: _navigationLabels[index],
      ),
    );

    return BlocProvider.value(
      value: _planBloc,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: navigationItems,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.whiteColor,
          unselectedItemColor: AppColors.unselectedTab,
          showUnselectedLabels: true,
          selectedLabelStyle: AppTextStyles.selectedTabTextStyle,
          unselectedLabelStyle: AppTextStyles.unselectedTabTextStyle,
          onTap: _onTabSelected,
        ),
      ),
    );
  }
}
