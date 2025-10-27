import 'package:flutter/material.dart';
import '../../../core/theme/tokens.dart';

class AdvancedBuilderPage extends StatefulWidget {
  final String projectId;
  const AdvancedBuilderPage({super.key, required this.projectId});

  @override
  State<AdvancedBuilderPage> createState() => _AdvancedBuilderPageState();
}

class _AdvancedBuilderPageState extends State<AdvancedBuilderPage> {
  List<String> headerComponents = [];
  List<String> bodyComponents = [];
  List<String> footerComponents = [];
  String selectedSlot = 'body';

  // Tema ayarları
  Color primaryColor = const Color(0xFF6750A4);
  Color backgroundColor = Colors.white;
  bool isDarkMode = false;

  // Şablon desteği
  String? selectedTemplate;

  // Mock data
  List<Map<String, dynamic>> mockProducts = [
    {'id': '1', 'name': 'Ürün 1', 'price': 99.99, 'image': '🎁'},
    {'id': '2', 'name': 'Ürün 2', 'price': 149.99, 'image': '🛍️'},
    {'id': '3', 'name': 'Ürün 3', 'price': 199.99, 'image': '📱'},
  ];

  final List<ComponentItem> components = [
    ComponentItem(icon: Icons.text_fields, name: 'Metin', type: 'Text'),
    ComponentItem(icon: Icons.smart_button, name: 'Buton', type: 'Button'),
    ComponentItem(icon: Icons.image, name: 'Görsel', type: 'Image'),
    ComponentItem(icon: Icons.card_travel, name: 'Kart', type: 'Card'),
    ComponentItem(icon: Icons.list, name: 'Liste', type: 'List'),
    ComponentItem(icon: Icons.search, name: 'Arama', type: 'Search'),
    ComponentItem(
        icon: Icons.notifications, name: 'Bildirim', type: 'Notification'),
  ];

  final List<TemplateItem> templates = [
    TemplateItem(
        name: 'E-Ticaret',
        icon: Icons.shopping_cart,
        desc: 'Ürün vitrinli mağaza'),
    TemplateItem(
        name: 'Blog', icon: Icons.article, desc: 'İçerik ve makale sitesi'),
    TemplateItem(
        name: 'Giriş Sayfası',
        icon: Icons.login,
        desc: 'Kayıt/Giriş ekranları'),
    TemplateItem(
        name: 'Landing', icon: Icons.dashboard, desc: 'Tanıtım sayfası'),
    TemplateItem(name: 'Boş', icon: Icons.add_box, desc: 'Temiz başlangıç'),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editör'),
          actions: [
            IconButton(
                icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => setState(() => isDarkMode = !isDarkMode)),
            IconButton(
                icon: const Icon(Icons.preview),
                onPressed: _showPreview,
                tooltip: 'Önizleme'),
            IconButton(icon: const Icon(Icons.save), onPressed: _saveProject),
          ],
        ),
        body: Row(
          children: [
            // Sol Sidebar
            _buildSidebar(),

            // Orta Canvas
            Expanded(child: _buildCanvas()),

            // Sağ Properties Panel
            _buildPropertiesPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.grey[100],
      child: Column(
        children: [
          _buildTab('components', Icons.widgets, 'Bileşenler', true),
          _buildTab('templates', Icons.style, 'Şablonlar', false),
          _buildTab('media', Icons.image, 'Medya', false),
          _buildTab('theme', Icons.palette, 'Tema', false),
          const Spacer(),
          FloatingActionButton(
            mini: true,
            onPressed: _addNewPage,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTab(String id, IconData icon, String label, bool active) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: active ? Colors.blue[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          Icon(icon, size: 20, color: active ? Colors.blue : Colors.grey),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal)),
        ]),
      ),
    );
  }

  Widget _buildCanvas() {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          // Header Slot
          _buildSlot('header', headerComponents, 'Header'),

          // Body
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  child: ListView.builder(
                    itemCount: components.length,
                    itemBuilder: (context, i) {
                      final c = components[i];
                      return _buildComponentItem(c);
                    },
                  ),
                ),
                Expanded(child: _buildBodyCanvas()),
              ],
            ),
          ),

          // Footer Slot
          _buildSlot('footer', footerComponents, 'Footer'),

          // Bottom Tabs
          Container(height: 55, child: _buildTabPreview()),
        ],
      ),
    );
  }

  Widget _buildComponentItem(ComponentItem c) {
    return InkWell(
      onTap: () => _addComponent(c.type),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(children: [
          Icon(c.icon, size: 18),
          const SizedBox(width: 6),
          Expanded(
              child: Text(c.name,
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.ellipsis)),
        ]),
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
              child: Row(
                children: [
                  const Spacer(),
                  Text('Body',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: selectedSlot == 'body'
                              ? Colors.blue
                              : Colors.grey)),
                ],
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
                          Text('Bileşen eklemek için soldan seçin',
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
                            trailing: PopupMenuButton(
                              itemBuilder: (_) => [
                                PopupMenuItem(
                                    child: const Text('Düzenle'),
                                    onTap: () => _editComponent(index)),
                                PopupMenuItem(
                                    child: const Text('Sil'),
                                    onTap: () => setState(
                                        () => bodyComponents.removeAt(index))),
                              ],
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

  Widget _buildSlot(String slot, List<String> items, String label) {
    final isSelected = selectedSlot == slot;
    return GestureDetector(
      onTap: () => setState(() => selectedSlot = slot),
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey[400]!,
              width: isSelected ? 2 : 1),
        ),
        child: Center(
          child: Text(
            '$label (${items.length})',
            style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Widget _buildTabPreview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem(Icons.dashboard, 'Ana'),
          _buildTabItem(Icons.list, 'Ürünler'),
          _buildTabItem(Icons.shopping_cart, 'Sepet'),
          _buildTabItem(Icons.person, 'Profil'),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String label) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: Colors.blue, size: 20),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 9, color: Colors.blue)),
    ]);
  }

  Widget _buildPropertiesPanel() {
    return Container(
      width: 280,
      color: Colors.grey[100],
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Özellikler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildColorPicker('Ana Renk', primaryColor,
                    (c) => setState(() => primaryColor = c)),
                const SizedBox(height: 12),
                _buildColorPicker('Arka Plan', backgroundColor,
                    (c) => setState(() => backgroundColor = c)),
                const Divider(height: 24),
                _buildToggle('Karanlık Mod', isDarkMode,
                    (v) => setState(() => isDarkMode = v)),
                const Divider(height: 24),
                _buildTemplateSelector(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker(
      String label, Color color, Function(Color) onChanged) {
    return InkWell(
      onTap: () => _showColorPicker(color, onChanged),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!)),
        child: Row(
          children: [
            Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(4))),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildTemplateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Şablonlar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        ...templates.map((t) => _buildTemplateCard(t)),
      ],
    );
  }

  Widget _buildTemplateCard(TemplateItem t) {
    return InkWell(
      onTap: () => _applyTemplate(t.name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!)),
        child: Row(
          children: [
            Icon(t.icon, size: 24, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(t.desc,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(Color color, Function(Color) onChanged) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Renk Seç'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildColorChip('Mor', const Color(0xFF6750A4), color, onChanged),
              _buildColorChip(
                  'Yeşil', const Color(0xFF2DB38A), color, onChanged),
              _buildColorChip(
                  'Mavi', const Color(0xFF2196F3), color, onChanged),
              _buildColorChip(
                  'Kırmızı', const Color(0xFFE5484D), color, onChanged),
              _buildColorChip(
                  'Turuncu', const Color(0xFFFF9800), color, onChanged),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorChip(
      String label, Color clr, Color selected, Function(Color) onChanged) {
    return ListTile(
      leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
              color: clr, borderRadius: BorderRadius.circular(4))),
      title: Text(label),
      onTap: () {
        onChanged(clr);
        Navigator.pop(context);
      },
    );
  }

  void _applyTemplate(String name) {
    setState(() {
      if (name == 'E-Ticaret') {
        bodyComponents = ['Search', 'List', 'Card'];
      } else if (name == 'Blog') {
        bodyComponents = ['Text', 'Image', 'List'];
      } else if (name == 'Giriş Sayfası') {
        bodyComponents = ['Form', 'Button'];
      } else if (name == 'Landing') {
        bodyComponents = ['Image', 'Text', 'Button'];
      } else {
        bodyComponents = [];
      }
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$name şablonu uygulandı')));
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
  }

  void _addNewPage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Yeni Sayfa'),
        content: const Text('Sayfa yönetimi yakında eklenecek'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam')),
        ],
      ),
    );
  }

  void _showPreview() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Önizleme'),
        content: Text(
            'Şu anda ${bodyComponents.length} bileşen eklediniz.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'))
        ],
      ),
    );
  }

  void _saveProject() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proje kaydedildi!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _editComponent(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${bodyComponents[index]} düzenleniyor...')),
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
      case 'Notification':
        return Icons.notifications;
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

class TemplateItem {
  final String name;
  final IconData icon;
  final String desc;
  TemplateItem({required this.name, required this.icon, required this.desc});
}
