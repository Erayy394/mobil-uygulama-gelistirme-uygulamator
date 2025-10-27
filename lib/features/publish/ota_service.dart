import 'dart:convert';

/// OTA (Over-The-Air) Update Service
class OTAService {
  static final OTAService instance = OTAService._();
  OTAService._();

  String currentVersion = '1.0.0';
  Map<String, dynamic>? lastManifest;

  /// Create new release manifest
  Future<Map<String, dynamic>> createRelease({
    required String projectId,
    required Map<String, dynamic> schema,
    String? notes,
  }) async {
    final manifest = {
      'version': _incrementVersion(currentVersion),
      'projectId': projectId,
      'schema': schema,
      'createdAt': DateTime.now().toIso8601String(),
      'notes': notes ?? 'Yeni güncelleme',
      'rolloutPercentage': 100, // %100 rollout
      'targets': ['all'], // Tüm kullanıcılar
    };

    lastManifest = manifest;
    currentVersion = manifest['version'];

    print('[OTA] Yeni release oluşturuldu: ${manifest['version']}');

    return manifest;
  }

  /// Get latest manifest
  Future<Map<String, dynamic>?> getLatestManifest(String projectId) async {
    if (lastManifest == null) return null;

    print('[OTA] Son release: $currentVersion');
    return lastManifest;
  }

  /// Rollout percentage ayarla
  Future<void> setRolloutPercentage(int percentage) async {
    if (lastManifest != null) {
      lastManifest!['rolloutPercentage'] = percentage;
      print('[OTA] Rollout: $percentage%');
    }
  }

  /// Rollback to previous version
  Future<void> rollback() async {
    if (currentVersion != '1.0.0') {
      currentVersion = _decrementVersion(currentVersion);
      print('[OTA] Rollback to: $currentVersion');
    }
  }

  String _incrementVersion(String v) {
    final parts = v.split('.');
    final major = int.parse(parts[0]);
    final minor = int.parse(parts[1]);
    final patch = int.parse(parts[2]);
    return '$major.$minor.${patch + 1}';
  }

  String _decrementVersion(String v) {
    final parts = v.split('.');
    final major = int.parse(parts[0]);
    final minor = int.parse(parts[1]);
    final patch = int.parse(parts[2]);
    if (patch > 0) {
      return '$major.$minor.${patch - 1}';
    }
    return v;
  }
}

/// Release management
class ReleaseService {
  static final ReleaseService instance = ReleaseService._();
  ReleaseService._();

  final List<Release> releases = [];

  Future<void> publishRelease({
    required String projectId,
    required Map<String, dynamic> schema,
    String? notes,
  }) async {
    final otaservice = OTAService.instance;
    final manifest = await otaservice.createRelease(
      projectId: projectId,
      schema: schema,
      notes: notes,
    );

    releases.add(Release(
      version: manifest['version'],
      projectId: projectId,
      notes: notes,
      createdAt: DateTime.now(),
    ));

    print('[Release] Yeni sürüm yayınlandı: ${manifest['version']}');
  }

  List<Release> getReleasesForProject(String projectId) {
    return releases.where((r) => r.projectId == projectId).toList();
  }
}

class Release {
  final String version;
  final String projectId;
  final String? notes;
  final DateTime createdAt;

  Release({
    required this.version,
    required this.projectId,
    this.notes,
    required this.createdAt,
  });
}
