import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/tokens.dart';
import 'panels/palette_panel.dart';
import 'panels/properties_panel.dart';
import 'canvas/drag_targets.dart';

/// Main builder page
class BuilderPage extends ConsumerStatefulWidget {
  final String projectId;

  const BuilderPage({
    super.key,
    required this.projectId,
  });

  @override
  ConsumerState<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends ConsumerState<BuilderPage> {
  String? selectedComponentId;
  Map<String, dynamic> componentProperties = {};

  void _handlePropertiesChanged(Map<String, dynamic> props) {
    setState(() {
      componentProperties = props;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editör'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              // TODO: Undo
            },
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              // TODO: Redo
            },
          ),
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              // TODO: Open preview
            },
          ),
          IconButton(
            icon: const Icon(Icons.publish),
            onPressed: () {
              // TODO: Publish
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 800) {
              // Mobile: Simple layout with floating button
              return Stack(
                children: [
                  _CanvasArea(
                    projectId: widget.projectId,
                    selectedComponentId: selectedComponentId,
                    onComponentSelected: (id) {},
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 400,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    'Sayfa Ekle',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.home),
                                  title: Text('Ana Sayfa Şablonu'),
                                  subtitle: Text('Header + Body + Footer'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    // TODO: Add page
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.app_registration),
                                  title: Text('Giriş/Kayıt Sayfası'),
                                  subtitle: Text('Kullanıcı kimlik doğrulama'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    // TODO: Add auth page
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.list),
                                  title: Text('Liste Sayfası'),
                                  subtitle: Text('Ürünler, haberler vs.'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    // TODO: Add list page
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.card_giftcard),
                                  title: Text('Boş Sayfa'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    // TODO: Add blank page
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              );
            } else {
              // Desktop: 3 column layout
              return Row(
                children: [
                  SizedBox(
                    width: 280,
                    child: PalettePanel(onItemSelected: _onPaletteItemSelected),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: _CanvasArea(
                      projectId: widget.projectId,
                      selectedComponentId: selectedComponentId,
                      onComponentSelected: (id) {},
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  SizedBox(
                    width: 320,
                    child: PropertiesPanel(
                      selectedComponentId: selectedComponentId,
                      properties: componentProperties,
                      onPropertiesChanged: _handlePropertiesChanged,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _onPaletteItemSelected(paletteItem) {
    // TODO: Handle palette item selection
  }
}

class _CanvasArea extends StatelessWidget {
  final String projectId;
  final String? selectedComponentId;
  final ValueChanged<String?> onComponentSelected;

  const _CanvasArea({
    required this.projectId,
    this.selectedComponentId,
    required this.onComponentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Container(
          width: 375, // iPhone width
          height: 812, // iPhone height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Tokens.radiusXl),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Tokens.radiusXl),
            child: Column(
              children: [
                // Status bar
                Container(
                  height: 44,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '9:41',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.signal_cellular_alt,
                              size: 16, color: Colors.white),
                          Icon(Icons.wifi, size: 16, color: Colors.white),
                          Icon(Icons.battery_full,
                              size: 16, color: Colors.white),
                        ],
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),

                // Content area
                Expanded(
                  child: _buildPreviewContent(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewContent(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.build_circle_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Editör',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sağ alttaki + butonuna tıklayarak\nyeni sayfa ekleyebilirsiniz',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        'Hazır Şablonlar',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
