import 'package:flutter/material.dart';
import '../../domain/entities.dart';

/// Component palette panel
class PalettePanel extends StatelessWidget {
  final ValueChanged<ComponentPaletteItem> onItemSelected;
  final bool advancedMode;

  const PalettePanel({
    super.key,
    required this.onItemSelected,
    this.advancedMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = advancedMode
        ? defaultPaletteItems
        : defaultPaletteItems.where((item) => !item.advanced).toList();

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Bileşenler',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final item = items[index];
                return LongPressDraggable<ComponentPaletteItem>(
                  data: item,
                  feedback: Material(
                    child: _PaletteItemCard(item: item),
                  ),
                  child: _PaletteItemCard(item: item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PaletteItemCard extends StatelessWidget {
  final ComponentPaletteItem item;

  const _PaletteItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.build_outlined,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        title: Text(item.name),
        subtitle: Text(
          item.description,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.drag_handle),
          onPressed: null,
        ),
      ),
    );
  }
}
