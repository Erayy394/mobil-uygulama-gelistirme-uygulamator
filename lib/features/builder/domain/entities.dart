/// Builder-specific entities and domain models

/// Builder state
class BuilderState {
  final String projectId;
  final String? selectedPageId;
  final String? selectedComponentId;
  final List<UndoRedoAction> history;
  final int historyIndex;

  BuilderState({
    required this.projectId,
    this.selectedPageId,
    this.selectedComponentId,
    List<UndoRedoAction>? history,
    int? historyIndex,
  })  : history = history ?? [],
        historyIndex = historyIndex ?? -1;

  /// Check if can undo
  bool get canUndo => historyIndex >= 0;

  /// Check if can redo
  bool get canRedo => historyIndex < history.length - 1;

  /// Copy with
  BuilderState copyWith({
    String? selectedPageId,
    String? selectedComponentId,
    List<UndoRedoAction>? history,
    int? historyIndex,
  }) {
    return BuilderState(
      projectId: projectId,
      selectedPageId: selectedPageId ?? this.selectedPageId,
      selectedComponentId: selectedComponentId ?? this.selectedComponentId,
      history: history ?? this.history,
      historyIndex: historyIndex ?? this.historyIndex,
    );
  }
}

/// Undo/Redo action
class UndoRedoAction {
  final String type; // 'add', 'delete', 'modify', 'reorder'
  final String componentId;
  final dynamic data; // Previous state

  UndoRedoAction({
    required this.type,
    required this.componentId,
    required this.data,
  });
}

/// Component palette item
class ComponentPaletteItem {
  final String type;
  final String name;
  final String icon; // Icon name or asset path
  final String description;
  final bool advanced; // Only show in advanced mode

  const ComponentPaletteItem({
    required this.type,
    required this.name,
    required this.icon,
    required this.description,
    this.advanced = false,
  });
}

/// Mock palette items
const List<ComponentPaletteItem> defaultPaletteItems = [
  const ComponentPaletteItem(
    type: 'Text',
    name: 'Metin',
    icon: 'text_fields',
    description: 'Static text',
  ),
  const ComponentPaletteItem(
    type: 'Button',
    name: 'Buton',
    icon: 'smart_button',
    description: 'Clickable button',
  ),
  const ComponentPaletteItem(
    type: 'Image',
    name: 'Görsel',
    icon: 'image',
    description: 'Image display',
  ),
  const ComponentPaletteItem(
    type: 'Card',
    name: 'Kart',
    icon: 'card_travel',
    description: 'Card container',
  ),
  const ComponentPaletteItem(
    type: 'List',
    name: 'Liste',
    icon: 'list',
    description: 'List view',
  ),
  const ComponentPaletteItem(
    type: 'TextField',
    name: 'Metin Alanı',
    icon: 'edit',
    description: 'Text input',
  ),
  const ComponentPaletteItem(
    type: 'Switch',
    name: 'Anahtar',
    icon: 'toggle_on',
    description: 'Toggle switch',
  ),
  const ComponentPaletteItem(
    type: 'Spacer',
    name: 'Boşluk',
    icon: 'space_bar',
    description: 'Empty space',
  ),
  const ComponentPaletteItem(
    type: 'AppBar',
    name: 'Üst Çubuk',
    icon: 'web_asset',
    description: 'App bar',
  ),
  const ComponentPaletteItem(
    type: 'BottomNav',
    name: 'Alt Menü',
    icon: 'bottom_navigation',
    description: 'Bottom navigation',
    advanced: true,
  ),
];
