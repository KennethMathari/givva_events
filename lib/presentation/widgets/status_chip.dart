import 'package:flutter/material.dart';
import 'package:givva_events/data/models/fundraiser.dart';

/// A chip widget that displays the status of a fundraiser (Active, Closed, Archived).
class StatusChip extends StatelessWidget {
  /// Creates a [StatusChip].
  const StatusChip({
    required this.fundraiser,
    super.key,
  });

  /// The fundraiser whose status is displayed.
  final Fundraiser fundraiser;

  @override
  Widget build(BuildContext context) {
    String label;
    Color color;

    if (fundraiser.archivedAt != null) {
      label = 'Archived';
      color = Colors.purple;
    } else if (fundraiser.closedAt != null) {
      label = 'Closed';
      color = Colors.orange;
    } else {
      label = 'Active';
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
