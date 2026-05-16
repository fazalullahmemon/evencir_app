class PlanWorkoutEvent {
  const PlanWorkoutEvent({
    required this.id,
    required this.day,
    required this.badgeLabel,
    required this.title,
    required this.durationLabel,
  });

  final String id;
  final DateTime day;
  final String badgeLabel;
  final String title;
  final String durationLabel;

  PlanWorkoutEvent copyWith({
    String? id,
    DateTime? day,
    String? badgeLabel,
    String? title,
    String? durationLabel,
  }) {
    return PlanWorkoutEvent(
      id: id ?? this.id,
      day: day ?? this.day,
      badgeLabel: badgeLabel ?? this.badgeLabel,
      title: title ?? this.title,
      durationLabel: durationLabel ?? this.durationLabel,
    );
  }
}
