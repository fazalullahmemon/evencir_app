import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Mulish';

  // 1. Heading
  static TextStyle heading = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 23.sp,
    fontWeight: FontWeight.w600,
  
  );

  // 2. Title
  static TextStyle title = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.48,
  );

  // 3. Week Indicator Style
  static TextStyle weekIndicatorStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  // 4. Date Indicator Style
  static TextStyle dateIndicatorStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  // 5. Temperature Style
  static TextStyle temperatureStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  // 6. Calendar Day Name Style
  static TextStyle calendarDayNameStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );

  // 7. Calendar Day Date Style
  static TextStyle calendarDayDateStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  // 8. Calendar Month Style
  static TextStyle calendarMonthStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  // 9. Workout Widget Date Style
  static TextStyle workoutWidgetDateStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );

  // 10. Calories Number Style
  static TextStyle caloriesNumberStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 37.sp,
    fontWeight: FontWeight.w600,
  );

  // 11. Calories Text Style
  static TextStyle caloriesTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  // 12. Calories Remaining Style
  static TextStyle caloriesRemainingStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  // 13. Calories Range Style
  static TextStyle caloriesRangeStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // 14. Weight Number Style
  static TextStyle weightNumberStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
  );

  // 15. Weight Text Style
  static TextStyle weightTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  // 16. Weight Name Style
  static TextStyle weightNameStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  // 17. Selected Tab Text Style
  static TextStyle selectedTabTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  // 18. Unselected Tab Text Style
  static TextStyle unselectedTabTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
}
