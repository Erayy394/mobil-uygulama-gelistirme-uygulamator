import 'package:flutter/material.dart';

/// Basit ve çalışan builder page
class SimpleBuilderPage extends StatefulWidget {
  final String projectId;

  const SimpleBuilderPage({super.key, required this.projectId});

  @override
  State<SimpleBuilderPage> createState() => _SimpleBuilderPageState();
}

class _SimpleBuilderPageState extends State<SimpleBuilderPage> {
  List<String> headerComponents = [];
  List<String> bodyComponents = [];
  List<String> footerComponents = [];
  String selectedSlot = 'body'; // 'header', 'body', 'footer'

  final List<ComponentItem> components = [
    ComponentItem(icon: Icons.text_fields, name: 'Metin', type: 'Text'),
    ComponentItem(icon: Icons.smart_button, name: 'Buton', type: 'Button'),
    ComponentItem(icon: Icons.image, name: 'Görsel', type: 'Image'),
    ComponentItem(icon: Icons.card_travel, name: 'Kart', type: 'Card'),
    ComponentItem(icon: Icons.list, name: 'Liste', type: 'List'),
    ComponentItem(icon: Icons.search, name: 'Arama', type: 'Search'),
    ComponentItem(icon: Icons.app_registration, name: 'Form', type: 'Form'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editör'),
        actions: [
          IconButton(
              icon: const Icon(Icons.preview),
              onPressed: () {},
              tooltip: 'Önizleme'),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Kaydedildi!')));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Slot
          _buildSlot('header', headerComponents, 'Header (Üst Çubuk)'),

          // Body
          Expanded(
            child: Row(
              children: [
                // Sol Panel - Bileşenler
                _buildComponentPalette(),

                // Orta - Canvas
                Expanded(child: _buildBodyCanvas()),
              ],
            ),
          ),

          // Footer Slot
          _buildSlot('footer', footerComponents, 'Footer (Alt Çubuk)'),

          // Bottom Tab Preview
          Container(height: 60, child: _buildTabPreview()),
        ],
      ),
    );
  }

  Widget _buildSlot(String slot, List<String> items, String label) {
    final isSelected = selectedSlot == slot;
    return GestureDetector(
      onTap: () => setState(() => selectedSlot = slot),
      child: Container(
        height: 60,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey[400]!,
              width: isSelected ? 2 : 1),
        ),
        child: Center(
          child: Text(
            items.isEmpty ? label : '$label: ${items.join(", ")}',
            style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Widget _buildComponentPalette() {
    return Container(
      width: 150,
      color: Colors.grey[100],
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Bileşenler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: components.length,
              itemBuilder: (context, index) {
                final c = components[index];
                return InkWell(
                  onTap: () => _addComponent(c.type),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(c.icon, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(c.name,
                                style: const TextStyle(fontSize: 11),
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyCanvas() {
    return GestureDetector(
      onTap: () => setState(() => selectedSlot = 'body'),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selectedSlot == 'body' ? Colors.blue : Colors.grey[300]!,
              width: selectedSlot == 'body' ? 2 : 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Body (Orta Alan) - ${bodyComponents.length} bileşen',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: selectedSlot == 'body' ? Colors.blue : Colors.grey),
              ),
            ),
            Expanded(
              child: bodyComponents.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.drag_handle, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Soldan bileşen seçin',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: bodyComponents.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: ListTile(
                            leading:
                                Icon(_getIcon(bodyComponents[index]), size: 18),
                            title: Text(bodyComponents[index],
                                style: const TextStyle(fontSize: 11)),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, size: 18),
                              onPressed: () => setState(
                                  () => bodyComponents.removeAt(index)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPreview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabItem(Icons.dashboard, 'Ana'),
        _buildTabItem(Icons.list, 'Ürünler'),
        _buildTabItem(Icons.shopping_cart, 'Sepet'),
        _buildTabItem(Icons.person, 'Profil'),
      ],
    );
  }

  Widget _buildTabItem(IconData icon, String label) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.blue, size: 20),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 9, color: Colors.blue)),
    ]);
  }

  void _addComponent(String type) {
    setState(() {
      if (selectedSlot == 'header') {
        headerComponents.add(type);
      } else if (selectedSlot == 'body') {
        bodyComponents.add(type);
      } else {
        footerComponents.add(type);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('$type eklendi'),
          duration: const Duration(milliseconds: 500)),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'Text':
        return Icons.text_fields;
      case 'Button':
        return Icons.smart_button;
      case 'Image':
        return Icons.image;
      case 'Card':
        return Icons.card_travel;
      case 'List':
        return Icons.list;
      case 'Search':
        return Icons.search;
      case 'Form':
        return Icons.app_registration;
      default:
        return Icons.widgets;
    }
  }
}

class ComponentItem {
  final IconData icon;
  final String name;
  final String type;
  ComponentItem({required this.icon, required this.name, required this.type});
}
