import 'package:flutter/widgets.dart';
import 'package:fluxui_kit/fluxui_kit.dart';

import '../../domain/models/roadmap_entry.dart';

class RoadmapList extends StatelessWidget {
  const RoadmapList({
    super.key,
    required this.entries,
  });

  final List<RoadmapEntry> entries;

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      padding: EdgeInsets.zero,
      child: Column(
        children: entries
            .map(
              (entry) => AppRoadmapItem(
                title: entry.title,
                kindLabel: 'Task',
                categoryLabel: 'component',
                issueNumber: entry.issueNumber,
                owner: 'abdelrzz9',
                activityLabel: entry.activityLabel,
                state: _toAppRoadmapState(entry.state),
                isHighlighted: entry.isHighlighted,
                showDivider: entry != entries.last,
              ),
            )
            .toList(),
      ),
    );
  }

  AppRoadmapItemState _toAppRoadmapState(RoadmapEntryState state) {
    switch (state) {
      case RoadmapEntryState.completed:
        return AppRoadmapItemState.completed;
    }
  }
}
