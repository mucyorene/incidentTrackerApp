import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/profile/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'dart:developer';

class ItaApiUtils {
  static String baseUrl = "http://197.243.1.84:3020";
  static String login = "$baseUrl/users/login";
  static String profilePicture =
      "$baseUrl/uploads//users/profilePicture-1748607340320-742478406.jpg";
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
    return BaseOptions(
      responseType: ResponseType.json,
      headers: {
        "Authorization": "Bearer ${token?.data?.token}",
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
    try {
      if (kDebugMode) {
        print(e);
        print((e as TypeError).stackTrace);
      }
    } catch (e) {
      debugPrint("Another error Type");
    }

    return GenericResponseModel<T>(
      message: "${kDebugMode ? e : ItaApiUtils.errorMessage}",
      status: ResponseStatus.error,
      statusCode: 500,
    );
  }
}

Color getSnackBarColor(ResponseStatus status) {
  switch (status) {
    case ResponseStatus.completed:
      return Colors.blueAccent;
    case ResponseStatus.success:
      return Colors.green;
    default:
      return Colors.redAccent;
  }
}

void showSnackBar(
  BuildContext context,
  String text, {
  ResponseStatus status = ResponseStatus.failed,
  int duration = 3,
  int statusCode = 0,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      backgroundColor: getSnackBarColor(status),
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: statusCode == 500 ? "Report" : "",
        onPressed: () {},
      ),
    ),
  );
}

showWidgetDialog(
  double width,
  context,
  Widget widget, {
  bool overlay = true,
  bool overlayDismiss = true,
  bool canPop = true,
}) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: overlayDismiss,
    barrierLabel: "widget",
    barrierColor:
        overlay ? Colors.black.withOpacity(.5) : Colors.black.withOpacity(.1),
    pageBuilder: (BuildContext context, anim1, anim2) {
      return PopScope(
        canPop: canPop,
        child: Align(
          alignment:
              MediaQuery.of(context).size.width > 600
                  ? Alignment.center
                  : Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Dismissible(
              key: const Key("dismiss2"),
              direction: DismissDirection.down,
              confirmDismiss: (direction) => Future.value(canPop),
              onDismissed: (d) {
                Navigator.pop(context);
              },
              child: Dismissible(
                key: const Key("dismiss"),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) => Future.value(canPop),
                onDismissed: (d) {
                  Navigator.pop(context);
                },
                child: SafeArea(
                  bottom: MediaQuery.of(context).size.width > 600,
                  child: Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Axis.vertical,
                    children: [
                      Container(
                        height: 4,
                        width: 70,
                        margin: const EdgeInsets.only(bottom: 5, top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.8),
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding:
                              MediaQuery.of(context).size.width > 600
                                  ? const EdgeInsets.only(bottom: 20)
                                  : EdgeInsets.zero,
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  width < 660
                                      ? const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      )
                                      : const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                            ),
                            child: SizedBox(
                              width:
                                  width >= 1050
                                      ? width / 1.9
                                      : width >= 900
                                      ? width / 1.7
                                      : width >= 660
                                      ? width / 1.5
                                      : width,
                              child: widget,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(anim1),
        child: child,
      );
    },
  );
}
