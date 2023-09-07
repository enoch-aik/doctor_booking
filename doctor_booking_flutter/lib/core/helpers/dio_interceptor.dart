import 'package:dio/dio.dart';
import 'package:doctor_booking_client/doctor_booking_client.dart';
import 'package:doctor_booking_flutter/core/service_exceptions/service_exception.dart';
import 'package:doctor_booking_flutter/core/service_result/service_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

typedef TypeDef = Function();

Future<ApiResult<T>> apiInterceptor<T>(TypeDef func) async {
  try {
    final result = await func();

    return ApiResult.success(data: result);
  }
  //catch Serverpod exception
  on ServerpodClientException catch (exception) {
    return ApiResult.apiFailure(
        error: ApiExceptions.defaultError(exception.message),
        statusCode: exception.statusCode);
  } on FirebaseAuthException catch (exception) {
    return ApiResult.apiFailure(
        error: ApiExceptions.defaultError(
            exception.message ?? 'Unexpected error occurred'),
        statusCode: -1);
  }

  on FirebaseException catch (exception){
    return ApiResult.apiFailure(error: ApiExceptions.defaultError(exception.message??'Unexpected error occurred'));
  }
  on DioException catch (exception) {
    // log(exception.response.toString());
    return exception.response?.statusCode == 400 ||
            exception.response?.data['message'] != null
        ? ApiResult.apiFailure(
            error: ApiExceptions.defaultError(
                exception.response?.data['message'] is List
                    ? exception.response?.data['message'][0]
                    : exception.response?.data['message']),
            statusCode: 400)
        : ApiResult.apiFailure(
            error: ApiExceptions.getDioException(exception)!,
            statusCode: exception.response?.statusCode ?? -1);
  } on Error catch (e) {
    debugPrint(e.stackTrace.toString());
    return ApiResult.apiFailure(
        error: ApiExceptions.getDioException(e)!, statusCode: -1);
  } catch (e) {
    debugPrint(e.toString());
    return ApiResult.apiFailure(
        error: ApiExceptions.getDioException(e)!, statusCode: -1);
  }
}
