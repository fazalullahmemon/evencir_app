class HydrationLogData {
  const HydrationLogData({
    required this.currentMl,
    required this.goalMl,
    required this.addedMl,
  });

  final int currentMl;
  final int goalMl;
  final int addedMl;

  double get progressPercent {
    if (goalMl <= 0) {
      return 0;
    }
    return currentMl / goalMl;
  }
}
