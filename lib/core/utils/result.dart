import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// Result type for error handling (Either pattern)
@freezed
class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(Object error, String message) = Failure<T>;
}

/// Extension for convenience
extension ResultExtension<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => maybeWhen(
        success: (data) => data,
        failure: (_, __) => null,
        orElse: () => null,
      );

  T get dataOrThrow => when(
        success: (data) => data,
        failure: (error, message) => throw error,
      );

  Result<U> map<U>(U Function(T data) mapper) => when(
        success: (data) => Result.success(mapper(data)),
        failure: (error, message) => Result.failure(error, message),
      );
}
