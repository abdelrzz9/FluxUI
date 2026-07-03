enum RoadmapEntryState { completed }

class RoadmapEntry {
  const RoadmapEntry({
    required this.title,
    required this.issueNumber,
    required this.activityLabel,
    required this.state,
    this.isHighlighted = false,
  });

  final String title;
  final int issueNumber;
  final String activityLabel;
  final RoadmapEntryState state;
  final bool isHighlighted;
}
