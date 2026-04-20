import 'package:flutter/material.dart';
import 'package:givva_events/data/models/fundraiser.dart';

class PaginationControls extends StatelessWidget {
  final Pagination pagination;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.pagination,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            label: '< Previous',
            isEnabled: pagination.hasPrevious,
            onPressed: () => onPageChanged(pagination.page - 1),
          ),
          const SizedBox(width: 8),
          ...List.generate(pagination.totalPages, (index) {
            final isCurrentPage = index == pagination.page;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _buildPageButton(
                pageNumber: index + 1,
                isActive: isCurrentPage,
                onPressed: () => onPageChanged(index),
              ),
            );
          }),
          const SizedBox(width: 8),
          _buildActionButton(
            label: 'Next >',
            isEnabled: pagination.hasNext,
            onPressed: () => onPageChanged(pagination.page + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required bool isEnabled,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey[700],
        backgroundColor: Colors.white.withOpacity(0.8),
        disabledForegroundColor: Colors.grey[400],
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPageButton({
    required int pageNumber,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.teal : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Text(
          '$pageNumber',
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
