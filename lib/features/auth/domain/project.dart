import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'project.freezed.dart';
part 'project.g.dart';

/// Project domain model
@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String ownerId,
    required String name,
    String? description,
    String? environment, // dev, stage, prod
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<ProjectMember> members,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

/// Project member model
@freezed
class ProjectMember with _$ProjectMember {
  const factory ProjectMember({
    required String projectId,
    required String userId,
    required UserRole role,
    String? userEmail,
    String? userName,
  }) = _ProjectMember;

  factory ProjectMember.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberFromJson(json);
}
