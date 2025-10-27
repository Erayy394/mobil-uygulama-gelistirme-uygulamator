import 'package:flutter/material.dart';

/// Slot drop area for drag and drop
class SlotDropArea extends StatefulWidget {
  final String slotName;
  final VoidCallback onDrop;
  final String? type; // Component type
  final Widget? child;

  const SlotDropArea({
    super.key,
    required this.slotName,
    required this.onDrop,
    this.type,
    this.child,
  });

  @override
  State<SlotDropArea> createState() => _SlotDropAreaState();
}

class _SlotDropAreaState extends State<SlotDropArea> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DragTarget<String>(
      onWillAccept: (data) {
        setState(() => _isHovering = true);
        return true;
      },
      onLeave: (data) {
        setState(() => _isHovering = false);
      },
      onAccept: (data) {
        setState(() => _isHovering = false);
        widget.onDrop();
      },
      builder: (context, candidates, rejects) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHovering
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.3),
              width: _isHovering ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: _isHovering
                ? theme.colorScheme.primary.withOpacity(0.05)
                : Colors.transparent,
          ),
          child: widget.child ?? _buildEmptyState(),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final isEmpty = widget.child == null;

    if (!isEmpty) return const SizedBox.shrink();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.drag_handle,
            size: 32,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 8),
          Text(
            _isHovering ? 'Bırak' : 'Buraya sürükle',
            style: TextStyle(
              color: theme.colorScheme.outline,
              fontSize: 12,
            ),
          ),
          if (widget.slotName.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '(${widget.slotName})',
              style: TextStyle(
                color: theme.colorScheme.outline.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
