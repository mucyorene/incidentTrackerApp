import 'package:dio/dio.dart' show BaseOptions, Dio, DioException;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/models/user_profile.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/views/models/core_res.dart';

class SignInNotifier extends StateNotifier<GenericResponseModel<UserProfile>> {
  SignInNotifier(this.ref) : super(GenericResponseModel());
  Ref? ref;

  Future<GenericResponseModel<UserProfile>> signIn(
    UserProfile userProfileData,
  ) async {
    var dio = Dio(ItaApiUtils.getOptions(ref));
    state = GenericResponseModel(status: ResponseStatus.saving);

    state = GenericResponseModel(status: ResponseStatus.loading);
    try {
      var responses = await dio.post(
        ItaApiUtils.login,
        data: userProfileData.toJson(),
      );

      debugPrint("HI, HERE IS USER: ${responses.data}");
      return state;
    } on DioException catch (e) {
      state = ItaApiUtils.catchDioException(e);
      return state;
    } catch (e) {
      state = ItaApiUtils.catchException(e);
      return state;
    }
  }
}
