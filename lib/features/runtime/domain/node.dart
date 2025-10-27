import 'package:flutter/material.dart';
import '../../../core/utils/bind.dart';

/// Widget node for rendering
class WidgetNode {
  final String type;
  final Map<String, dynamic> props;
  final List<WidgetNode> children;
  final String? ref; // Reference to global component

  const WidgetNode({
    required this.type,
    this.props = const {},
    this.children = const [],
    this.ref,
  });
}

/// Render context for template evaluation
class RenderContext {
  final Map<String, dynamic> state;
  final Map<String, dynamic> datasources;
  final BuildContext buildContext;

  RenderContext({
    required this.buildContext,
    this.state = const {},
    this.datasources = const {},
  });

  /// Get value from context
  dynamic get(String key) {
    if (key.startsWith('state.')) {
      return _getNested(state, key.substring(6));
    }
    if (key.startsWith('datasource.')) {
      return _getNested(datasources, key.substring(11));
    }
    return state[key] ?? datasources[key];
  }

  dynamic _getNested(Map<String, dynamic> map, String key) {
    final parts = key.split('.');
    dynamic current = map;
    for (final part in parts) {
      if (current is Map<String, dynamic>) {
        current = current[part];
      } else {
        return null;
      }
    }
    return current;
  }
}
