import 'package:flutter/material.dart';
import '../../builder/data/dsl_models.dart' as builder;
import '../domain/node.dart';
import '../domain/actions.dart';
import '../../../core/utils/bind.dart';
import '../../../core/theme/tokens.dart';

/// Render DSL to Flutter widgets
class RuntimeRenderer {
  /// Render a page from schema
  static Widget renderPage(builder.PageSchema page, builder.AppSchema schema) {
    return _buildLayout(page.layout, schema);
  }

  static Widget _buildLayout(
      builder.LayoutSchema layout, builder.AppSchema schema) {
    return Scaffold(
      appBar: layout.header != null
          ? AppBar(
              title: Text('App'),
            )
          : null,
      body: _buildComponent(layout.body, schema),
    );
  }

  static Widget _buildComponent(
      builder.ComponentNode node, builder.AppSchema schema) {
    // Check for reference
    if (node.ref != null) {
      final component = schema.components.isNotEmpty
          ? schema.components.firstWhere(
              (c) => c.id == node.ref,
              orElse: () => schema.components.first,
            )
          : null;

      if (component == null) return const SizedBox();
      return _buildComponent(component.schema, schema);
    }

    // Build widget based on type
    switch (node.type) {
      case 'Text':
        return _buildText(node);
      case 'Button':
        return _buildButton(node);
      case 'Image':
        return _buildImage(node);
      case 'Card':
        return _buildCard(node, schema);
      case 'Column':
        return _buildColumn(node, schema);
      case 'Row':
        return _buildRow(node, schema);
      case 'TextField':
        return _buildTextField(node);
      case 'Switch':
        return _buildSwitch(node);
      case 'Spacer':
        return _buildSpacer(node);
      case 'List':
        return _buildList(node, schema);
      case 'Container':
        return _buildContainer(node, schema);
      default:
        return _buildUnknown(node, schema);
    }
  }

  static Widget _buildText(builder.ComponentNode node) {
    final text = node.props['text']?.toString() ?? '';
    final evaluatedText = BindingEvaluator.evaluate(text, {});

    return Text(
      evaluatedText,
      style: TextStyle(
        fontSize: (node.props['fontSize'] as num?)?.toDouble() ?? 16,
        fontWeight:
            node.props['bold'] == true ? FontWeight.bold : FontWeight.normal,
      ),
      textAlign: _getTextAlign(node.props['textAlign']?.toString()),
    );
  }

  static Widget _buildButton(builder.ComponentNode node) {
    final text = node.props['text']?.toString() ?? 'Button';
    final actions = node.actions;

    return ElevatedButton(
      onPressed: actions.isNotEmpty
          ? () {
              for (final action in actions) {
                final type = _getActionType(action.do_);
                ActionHandler.handleAction(
                  action: type,
                  params: {
                    'to': action.to,
                    'source': action.source,
                    ...?action.params,
                  },
                  context: /* TODO: Get context */ _getDummyContext(),
                );
              }
            }
          : null,
      child: Text(text),
    );
  }

  static Widget _buildImage(builder.ComponentNode node) {
    final src = node.props['src']?.toString() ?? '';

    return src.startsWith('http') ? Image.network(src) : Image.asset(src);
  }

  static Widget _buildCard(
      builder.ComponentNode node, builder.AppSchema schema) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Tokens.spacing),
        child: node.children.isNotEmpty
            ? _buildColumn(
                builder.ComponentNode(type: 'Column', children: node.children),
                schema)
            : const SizedBox(),
      ),
    );
  }

  static Widget _buildColumn(
      builder.ComponentNode node, builder.AppSchema schema) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: node.children
            .map((child) => _buildComponent(child, schema))
            .toList(),
      ),
    );
  }

  static Widget _buildRow(
      builder.ComponentNode node, builder.AppSchema schema) {
    return Row(
      children:
          node.children.map((child) => _buildComponent(child, schema)).toList(),
    );
  }

  static Widget _buildTextField(builder.ComponentNode node) {
    return TextField(
      decoration: InputDecoration(
        labelText: node.props['label']?.toString(),
        hintText: node.props['hint']?.toString(),
      ),
    );
  }

  static Widget _buildSwitch(builder.ComponentNode node) {
    return Switch(
      value: node.props['value'] == true,
      onChanged: (_) {},
    );
  }

  static Widget _buildSpacer(builder.ComponentNode node) {
    final height = (node.props['height'] as num?)?.toDouble() ?? 16;
    return SizedBox(height: height);
  }

  static Widget _buildList(
      builder.ComponentNode node, builder.AppSchema schema) {
    // TODO: Implement list rendering
    return const Center(child: Text('List'));
  }

  static Widget _buildContainer(
      builder.ComponentNode node, builder.AppSchema schema) {
    final color = node.props['color']?.toString();

    return Container(
      color: color != null
          ? Color(int.parse(color.replaceFirst('#', '0xFF')))
          : null,
      child: node.children.isNotEmpty
          ? _buildColumn(
              builder.ComponentNode(type: 'Column', children: node.children),
              schema)
          : null,
    );
  }

  static Widget _buildUnknown(
      builder.ComponentNode node, builder.AppSchema schema) {
    return Center(
      child: Text('Unknown component: ${node.type}'),
    );
  }

  static TextAlign? _getTextAlign(String? align) {
    switch (align?.toLowerCase()) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      case 'left':
        return TextAlign.left;
      default:
        return null;
    }
  }

  static ActionType _getActionType(String action) {
    switch (action) {
      case 'navigate':
        return ActionType.navigate;
      case 'openUrl':
        return ActionType.openUrl;
      case 'setState':
        return ActionType.setState;
      case 'fetch':
        return ActionType.fetch;
      case 'showToast':
        return ActionType.showToast;
      case 'submitForm':
        return ActionType.submitForm;
      case 'refresh':
        return ActionType.refresh;
      default:
        return ActionType.showToast;
    }
  }

  static BuildContext _getDummyContext() {
    // TODO: Proper context handling
    return ErrorWidget.builder as BuildContext;
  }
}

/// Runtime preview page
class RuntimePreviewPage extends StatelessWidget {
  final String projectId;

  const RuntimePreviewPage({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Load schema from project
    final mockSchema = const builder.AppSchema(
      theme: builder.ThemeConfig(),
      pages: [
        builder.PageSchema(
          id: 'home',
          name: 'Home',
          route: '/',
          layout: builder.LayoutSchema(
            body: builder.ComponentNode(
              type: 'Column',
              props: {'padding': 16},
              children: [
                builder.ComponentNode(
                  type: 'Text',
                  props: {'text': 'Hoş geldiniz!'},
                ),
                builder.ComponentNode(
                  type: 'Button',
                  props: {'text': 'Başla'},
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return RuntimeRenderer.renderPage(mockSchema.pages.first, mockSchema);
  }
}
