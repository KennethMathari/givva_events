import 'package:flutter/material.dart';
import 'package:givva_events/data/models/fundraiser.dart';

class StatusChip extends StatelessWidget {
  final Fundraiser fundraiser;

  const StatusChip({super.key, required this.fundraiser});

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
        color: color.withOpacity(0.1),
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
