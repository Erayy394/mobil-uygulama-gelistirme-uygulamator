import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User domain model
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? name,
    String? photo,
    DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// User role enum
enum UserRole {
  owner,
  editor,
  viewer,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.owner:
        return 'Owner';
      case UserRole.editor:
        return 'Editor';
      case UserRole.viewer:
        return 'Viewer';
    }
  }

  bool get canEdit => this == UserRole.owner || this == UserRole.editor;
  bool get canDelete => this == UserRole.owner;
}
