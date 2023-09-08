import 'package:doctor_booking_flutter/core/service_exceptions/service_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.apiFailure({
    required ApiExceptions error,
    @Default(-1) int statusCode,
  }) = Failure<T>;

 /* AsyncValue<T> asyncGuard() {
    return when(
        success: (data) => AsyncData(data),
        apiFailure: (error, _) => AsyncError(error, StackTrace.empty));
  }

  T extract() {
    return when(success: (data) => data, apiFailure: (error, _) => throw error);
  }*/
}

/*
@override
  AsyncValue<T> asyncGuard() {
    return when(
        success: (data) => AsyncData(data),
        apiFailure: (error, _) => AsyncError(error, StackTrace.empty));
  }

  @override
  T extract() {
    return when(success: (data) => data, apiFailure: (error, _) => throw error);
  }
  */