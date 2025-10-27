import 'dsl_models.dart';
import '../../auth/domain/project.dart';

/// Project repository for builder
class ProjectRepository {
  /// Get project schema
  Future<AppSchema> getProjectSchema(String projectId) async {
    // TODO: Fetch from Supabase
    await Future.delayed(const Duration(milliseconds: 100));

    // Mock data for now
    return const AppSchema(
      theme: ThemeConfig(
        primary: '#6750A4',
        radius: 12,
        font: 'Inter',
      ),
      pages: [
        PageSchema(
          id: 'home',
          name: 'Ana Sayfa',
          route: '/',
          layout: LayoutSchema(
            body: ComponentNode(
              type: 'Column',
              props: {
                'padding': 16,
                'scroll': true,
              },
              children: [
                ComponentNode(
                  type: 'Text',
                  props: {'text': 'Hoş geldiniz!'},
                ),
                ComponentNode(
                  type: 'Button',
                  props: {'text': 'Başla'},
                  actions: [
                    ActionConfig(
                      on: 'tap',
                      do_: 'navigate',
                      to: '/products',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Save project schema
  Future<void> saveProjectSchema(String projectId, AppSchema schema) async {
    // TODO: Save to Supabase
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Create new page
  Future<void> createPage(String projectId, PageSchema page) async {
    // TODO: Save to database
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Delete page
  Future<void> deletePage(String projectId, String pageId) async {
    // TODO: Delete from database
    await Future.delayed(const Duration(milliseconds: 100));
  }

  /// Get project members
  Future<List<ProjectMember>> getProjectMembers(String projectId) async {
    // TODO: Fetch from Supabase
    return [];
  }
}
