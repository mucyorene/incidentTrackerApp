import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/views/ita_providers/common_providers.dart';
import 'package:incident_tracker_app/views/models/core_res.dart';
import 'dart:developer';

class ItaApiUtils {
  static String baseUrl = "http://197.243.1.84:3020";
  static String login = "$baseUrl/users/login";
  static String responseErrorMessage = "Response error message";
  static String errorMessage = "There is error happened";

  static Dio createDioObject(BaseOptions options) {
    Dio dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("${options.uri}");
          log("${options.headers}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  static BaseOptions getOptions(Ref? ref) {
    var token = ref?.read(authTokenProvider);
    var lang = "en-US";
    // var lang = ref?.read(languageProvider);
    return BaseOptions(
      responseType: ResponseType.json,
      headers: {
        "Authorization": "Bearer $token",
        "lang": lang,
        "Accept": "application/json",
      },
    );
  }

  static GenericResponseModel<T> catchDioException<T>(DioException e) {
    {
      try {
        var errorRes =
            e.response?.data != null
                ? e.response?.data["message"] ?? e.response?.data["error"]
                : null;
        var msg = getNetworkMessage(e);

        GenericResponseModel<T> info = GenericResponseModel();

        if (errorRes == null) {
          info = GenericResponseModel<T>(
            status: ResponseStatus.failed,
            statusCode: e.response?.statusCode ?? 0,
            errors: [e.message ?? ""],
            message: msg,
          );
        } else {
          info = GenericResponseModel<T>(
            status: ResponseStatus.failed,
            statusCode: e.response?.statusCode ?? 0,
            errors: [errorRes],
            message: msg,
          );
        }

        return info;
      } catch (error, t) {
        try {
          log(json.encode(e.requestOptions.data));
          log("errorrr    $error");
        } catch (e) {
          log("Can't print request data");
        }
        debugPrint("${e.requestOptions.uri}");
        debugPrint("${e.response?.statusCode}");
        log("${e.response?.data}");
        debugPrint(e.requestOptions.method);
        log("${e.requestOptions.headers}");

        var msg = '';
        try {
          msg =
              e.response?.data == null
                  ? getNetworkMessage(e)
                  : GenericResponseModel.fromJson(
                    e.response!.data,
                  ).errorMessage;
        } catch (e2) {
          debugPrint("$e");
          msg = responseErrorMessage;
        }

        Map<String, dynamic> errorsObj =
            e.response?.data == null
                ? {}
                : e.response!.data['errors'] == null ||
                    !e.response!.data['errors'].runtimeType.toString().contains(
                      "Map",
                    )
                ? {}
                : e.response!.data['errors'];

        GenericResponseModel<T> info = GenericResponseModel(
          status: ResponseStatus.failed,
          statusCode: e.response?.statusCode ?? 0,
          message: msg,
          errorsObject: errorsObj,
        );
        return info;
      }
    }
  }

  static String getNetworkMessage(DioException e) {
    var msg = "";
    var errorRes = e.response?.data ?? "{}";
    switch (e.type) {
      case DioExceptionType.sendTimeout:
        msg = "Server timeout issue";
        break;
      case DioExceptionType.connectionTimeout:
        msg = "Connection time out";
        break;
      case DioExceptionType.receiveTimeout:
        msg = "Received timout";
        break;
      case DioExceptionType.badResponse:
        msg =
            errorRes['message'] ??
            errorRes['error'] ??
            "Internet issues, bad response";
        break;
      case DioExceptionType.cancel:
        msg = "Request canceled";
        break;
      case DioExceptionType.unknown:
        msg = "Network unknown issue";
        break;
      case DioExceptionType.connectionError:
        msg = "No internet, connection error";
        break;
      case DioExceptionType.badCertificate:
        msg = "Wrong certificate";
        break;
    }
    return msg;
  }

  static GenericResponseModel<T> catchException<T>(e) {
    // Sentry.captureException(
    //   e,
    // );
    try {
      if (kDebugMode) {
        print(e);
        print((e as TypeError).stackTrace);
      }
    } catch (e) {
      debugPrint("Another error Type");
      // Sentry.captureException(
      //   e,
      //   stackTrace: t,
      // );
    }

    return GenericResponseModel<T>(
      message: "${kDebugMode ? e : ItaApiUtils.errorMessage}",
      status: ResponseStatus.error,
      statusCode: 500,
    );
  }
}
