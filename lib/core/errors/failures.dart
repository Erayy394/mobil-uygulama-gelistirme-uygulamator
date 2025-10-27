import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class
@freezed
class Failure with _$Failure {
  const factory Failure({
    required String message,
    String? code,
    dynamic error,
  }) = _Failure;

  const factory Failure.network({
    required String message,
    int? statusCode,
  }) = NetworkFailure;

  const factory Failure.authentication({
    required String message,
  }) = AuthenticationFailure;

  const factory Failure.authorization({
    required String message,
  }) = AuthorizationFailure;

  const factory Failure.validation({
    required String message,
    Map<String, String>? errors,
  }) = ValidationFailure;

  const factory Failure.notFound({
    required String resource,
  }) = NotFoundFailure;

  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  const factory Failure.unknown({
    dynamic error,
  }) = UnknownFailure;
}
