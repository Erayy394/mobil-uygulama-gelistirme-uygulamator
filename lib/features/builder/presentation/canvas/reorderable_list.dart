import 'package:flutter/material.dart';

/// Reorderable list for component children
class ReorderableComponentList extends StatelessWidget {
  final List<Widget> children;
  final ValueChanged<int> onReorder;

  const ReorderableComponentList({
    super.key,
    required this.children,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: true,
      buildDefaultDragHandles: true,
      onReorder: (oldIndex, newIndex) {
        onReorder(oldIndex);
      },
      children: children,
    );
  }
}
