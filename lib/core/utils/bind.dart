/// Template binding evaluator for {{ }} expressions
class BindingEvaluator {
  /// Evaluaate {{ }} expressions in strings
  /// Examples: {{user.name}}, {{state.count}}, {{datasource.products | length}}
  static String evaluate(String template, Map<String, dynamic> context) {
    if (!template.contains('{{')) {
      return template;
    }

    final regex = RegExp(r'\{\{([^}]+)\}\}');
    return template.replaceAllMapped(regex, (match) {
      final expression = match.group(1)?.trim() ?? '';
      final value = _evaluateExpression(expression, context);
      return value?.toString() ?? '';
    });
  }

  /// Evaluate a single expression (simple property access only)
  static dynamic _evaluateExpression(
      String expr, Map<String, dynamic> context) {
    if (expr.contains('|')) {
      return _evaluateWithFilter(expr, context);
    }

    // Simple property access: datasource.products -> context['datasource']['products']
    if (expr.contains('.')) {
      final parts = expr.split('.');
      dynamic current = context;

      for (final part in parts) {
        if (current is Map<String, dynamic>) {
          current = current[part.trim()];
        } else {
          return null;
        }
      }

      return current;
    }

    // Direct access: state -> context['state']
    return context[expr.trim()];
  }

  /// Evaluate expressions with filters (e.g., {{list | length}})
  static dynamic _evaluateWithFilter(
      String expr, Map<String, dynamic> context) {
    final parts = expr.split('|');
    if (parts.length != 2) return null;

    final valueExpr = parts[0].trim();
    final filterName = parts[1].trim();

    final value = _evaluateExpression(valueExpr, context);

    switch (filterName) {
      case 'length':
        if (value is List || value is String) {
          return value.length;
        }
        break;
      case 'uppercase':
        if (value is String) return value.toUpperCase();
        break;
      case 'lowercase':
        if (value is String) return value.toLowerCase();
        break;
      case 'capitalize':
        if (value is String && value.isNotEmpty) {
          return value[0].toUpperCase() + value.substring(1).toLowerCase();
        }
        break;
      case 'plural':
        // Simple: returns 's' if not 1
        if (value is int && value != 1) return 's';
        return '';
      default:
        return value;
    }

    return value;
  }

  /// Extract all variable names from a template
  static List<String> extractVariables(String template) {
    final regex = RegExp(r'\{\{([^}]+)\}\}');
    final matches = regex.allMatches(template);

    return matches
        .map((m) => m.group(1)?.trim() ?? '')
        .where((v) => v.isNotEmpty)
        .toList();
  }

  /// Check if template has bindings
  static bool hasBindings(String template) {
    return template.contains('{{');
  }
}
