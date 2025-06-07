import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/profile/providers.dart';
import 'package:incident_tracker_app/models/user_profile.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInNotifier extends StateNotifier<GenericResponseModel<UserProfile>> {
  SignInNotifier(this.ref) : super(GenericResponseModel());
  Ref? ref;

  Future<GenericResponseModel<UserProfile>> signIn({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var dio = Dio(ItaApiUtils.getOptions(ref));
    state = GenericResponseModel(status: ResponseStatus.saving);
    try {
      var responses = await dio.post(
        ItaApiUtils.login,
        data: {"email": email, "password": password},
      );
      var loginResponse = UserProfile.fromJson(responses.data);
      await prefs.setString('token', loginResponse.token);
      await prefs.setString('user', json.encode(loginResponse.user.toJson()));
      ref?.read(authTokenProvider.notifier).autoLogin();
      state = GenericResponseModel.fromJson(
        responses.data,
        status: ResponseStatus.success,
        defaultData: loginResponse,
      );
      return state;
    } on DioException catch (e) {
      state = ItaApiUtils.catchDioException(e);
      return state;
    } catch (e) {
      state = ItaApiUtils.catchException(e);
      return state;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    state = GenericResponseModel();
  }
}
