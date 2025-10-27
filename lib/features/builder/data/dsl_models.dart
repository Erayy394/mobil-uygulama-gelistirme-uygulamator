import 'package:freezed_annotation/freezed_annotation.dart';

part 'dsl_models.freezed.dart';
part 'dsl_models.g.dart';

/// Root DSL model for the entire app schema
@freezed
class AppSchema with _$AppSchema {
  const factory AppSchema({
    @Default(1) int version,
    ThemeConfig? theme,
    @Default([]) List<PageSchema> pages,
    @Default([]) List<ComponentSchema> components,
    @Default([]) List<DataSourceSchema> dataSources,
    @Default([]) List<ActionSchema> actions,
  }) = _AppSchema;

  factory AppSchema.fromJson(Map<String, dynamic> json) =>
      _$AppSchemaFromJson(json);
}

/// Theme configuration
@freezed
class ThemeConfig with _$ThemeConfig {
  const factory ThemeConfig({
    @Default('#6750A4') String primary,
    @Default('#625B71') String secondary,
    @Default('#FFFFFF') String background,
    @Default('#000000') String text,
    @Default(12.0) double radius,
    @Default('Inter') String font,
    @Default('light') String mode,
  }) = _ThemeConfig;

  factory ThemeConfig.fromJson(Map<String, dynamic> json) =>
      _$ThemeConfigFromJson(json);
}

/// Page schema
@freezed
class PageSchema with _$PageSchema {
  const factory PageSchema({
    required String id,
    required String name,
    required String route,
    required LayoutSchema layout,
    @Default(0) int order,
  }) = _PageSchema;

  factory PageSchema.fromJson(Map<String, dynamic> json) =>
      _$PageSchemaFromJson(json);
}

/// Layout schema with header, body, footer slots
@freezed
class LayoutSchema with _$LayoutSchema {
  const factory LayoutSchema({
    ComponentNode? header,
    required ComponentNode body,
    ComponentNode? footer,
  }) = _LayoutSchema;

  factory LayoutSchema.fromJson(Map<String, dynamic> json) =>
      _$LayoutSchemaFromJson(json);
}

/// Component node (recursive)
@freezed
class ComponentNode with _$ComponentNode {
  const factory ComponentNode({
    String? ref, // Reference to a global component
    required String type, // Text, Button, Column, etc.
    @Default({}) Map<String, dynamic> props,
    @Default([]) List<ActionConfig> actions,
    @Default([]) List<ComponentNode> children,
  }) = _ComponentNode;

  factory ComponentNode.fromJson(Map<String, dynamic> json) =>
      _$ComponentNodeFromJson(json);
}

/// Action configuration
@JsonSerializable()
class ActionConfig {
  final String on; // 'tap', 'longPress', 'init', etc.
  final String do_; // 'navigate', 'fetch', 'setState', etc.
  final String? to; // route or URL
  final String? source; // data source ID
  final Map<String, dynamic>? params;

  const ActionConfig({
    required this.on,
    required this.do_,
    this.to,
    this.source,
    this.params,
  });

  factory ActionConfig.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> json_ = Map<String, dynamic>.from(json);
    if (json_.containsKey('do') && !json_.containsKey('do_')) {
      json_['do_'] = json_['do'];
    }
    try {
      return _$ActionConfigFromJson(json_);
    } catch (e) {
      return ActionConfig(
        on: json['on'] as String,
        do_: json['do_'] as String? ?? json['do'] as String,
        to: json['to'] as String?,
        source: json['source'] as String?,
        params: json['params'] as Map<String, dynamic>?,
      );
    }
  }

  Map<String, dynamic> toJson() {
    final map = {
      'on': on,
      'do': do_,
      if (to != null) 'to': to,
      if (source != null) 'source': source,
      if (params != null) 'params': params,
    };
    return map;
  }
}

/// Component schema (reusable components)
@freezed
class ComponentSchema with _$ComponentSchema {
  const factory ComponentSchema({
    required String id,
    required String name,
    required ComponentNode schema,
  }) = _ComponentSchema;

  factory ComponentSchema.fromJson(Map<String, dynamic> json) =>
      _$ComponentSchemaFromJson(json);
}

/// Data source schema
@freezed
class DataSourceSchema with _$DataSourceSchema {
  const factory DataSourceSchema({
    required String id,
    required String type, // 'rest', 'mock', 'local'
    Map<String, dynamic>? config,
    @Default(false) bool secure,
  }) = _DataSourceSchema;

  factory DataSourceSchema.fromJson(Map<String, dynamic> json) =>
      _$DataSourceSchemaFromJson(json);
}

/// Action schema (global actions/triggers)
@freezed
class ActionSchema with _$ActionSchema {
  const factory ActionSchema({
    required String id,
    String? pageId,
    required String trigger,
    Map<String, dynamic>? flow,
  }) = _ActionSchema;

  factory ActionSchema.fromJson(Map<String, dynamic> json) =>
      _$ActionSchemaFromJson(json);
}

/// Supported component types
enum ComponentType {
  text,
  button,
  image,
  list,
  card,
  textField,
  switch_,
  spacer,
  appBar,
  bottomNav,
  modalSheet,
  column,
  row,
  container,
}

/// Supported action types
enum ActionType {
  navigate, // Go to a page
  openUrl, // Open external URL
  setState, // Update component state
  fetch, // Fetch data from datasource
  showToast, // Show toast message
  submitForm, // Submit form data
  refresh, // Refresh datasource
}
