class CalorieInsightData {
  const CalorieInsightData({
    required this.caloriesBurned,
    required this.caloriesRemaining,
    required this.totalCalories,
  });

  final int caloriesBurned;
  final int caloriesRemaining;
  final int totalCalories;

  double get progress {
    if (totalCalories <= 0) {
      return 0;
    }
    return caloriesBurned / totalCalories;
  }
}
