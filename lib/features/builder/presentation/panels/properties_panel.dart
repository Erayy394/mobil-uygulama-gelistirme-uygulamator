import 'package:flutter/material.dart';
import '../../../../core/theme/tokens.dart';

/// Properties panel for selected component
class PropertiesPanel extends StatelessWidget {
  final String? selectedComponentId;
  final Map<String, dynamic> properties;
  final ValueChanged<Map<String, dynamic>> onPropertiesChanged;

  const PropertiesPanel({
    super.key,
    this.selectedComponentId,
    required this.properties,
    required this.onPropertiesChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedComponentId == null) {
      return _buildEmptyState(context);
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Özellikler',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // TODO: Deselect
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildPropertyFields(context),
                const SizedBox(height: 24.0),
                _buildActionsSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune,
              size: 48,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Bir bileşen seçin',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyFields(BuildContext context) {
    // TODO: Dynamic fields based on component type
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genel',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Label',
            hintText: 'Bir label girin',
          ),
          onChanged: (value) {
            onPropertiesChanged({...properties, 'label': value});
          },
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aksiyonlar',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.touch_app),
          title: const Text('Tıklama Aksiyonu'),
          subtitle: const Text('Seç aksiyon'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Show action picker
          },
        ),
      ],
    );
  }
}
