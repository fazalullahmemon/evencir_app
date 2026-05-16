import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/presentation/widgets/mood_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: ColoredBox(color: Colors.black)),
          Positioned(
            top: -220,
            left: -80,
            right: -80,
            child: IgnorePointer(
              child: AspectRatio(
                aspectRatio: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.5),
                      radius: 0.6,
                      colors: const [
                        Color(0xFF5F79B8),
                        AppColors.moodGradientTop,
                        Colors.black,
                      ],
                      stops: const [0.0, 0.36, 0.8],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mood',
                    style: AppTextStyles.moodTitleStyle.copyWith(
                      color: AppColors.whiteColor,
                      height: 1.05,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Text(
                      'Start your day',
                      style: AppTextStyles.moodSubtitleStyle.copyWith(
                        color: AppColors.whiteColor,
                        height: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.only(left: 14.w),
                    child: Text(
                      'How are you feeling at the Moment?',
                      style: AppTextStyles.moodQuestionStyle.copyWith(
                        color: AppColors.whiteColor,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 72.h),
              child: const MoodSelectorWidget(),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Continue',
                    style: AppTextStyles.moodContinueButtonStyle.copyWith(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
