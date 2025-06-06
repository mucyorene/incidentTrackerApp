import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;
import 'package:incident_tracker_app/models/user_profile.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/models/core_res.dart';

class SignInNotifier extends StateNotifier<GenericResponseModel<UserProfile>> {
  SignInNotifier(this.ref) : super(GenericResponseModel());
  Ref? ref;

  final storage = const FlutterSecureStorage();

  Future<GenericResponseModel<UserProfile>> signIn({
    required String email,
    required String password,
  }) async {
    var dio = Dio(ItaApiUtils.getOptions(ref));
    state = GenericResponseModel(status: ResponseStatus.saving);
    try {
      var responses = await dio.post(
        ItaApiUtils.login,
        data: {"email": email, "password": password},
      );
      var loginResponse = UserProfile.fromJson(responses.data);
      print("HERE IS TOKEN: ${loginResponse.token}");
      await storage.write(key: 'token', value: loginResponse.token);
      await storage.write(
        key: 'user',
        value: json.encode(loginResponse.user.toJson()),
      );
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

  //Read user info from storage
  Future<GenericResponseModel<UserProfile>> autoLogin() async {
    var token = await storage.read(key: 'token');
    var user = await storage.read(key: 'user');
    if (token != null && user != null) {
      state = GenericResponseModel(status: ResponseStatus.loading);
      var auth = UserProfile.fromJsonLocal({
        "token": token,
        "user": jsonDecode(user),
      });
      state = GenericResponseModel(status: ResponseStatus.success, data: auth);
    } else {
      state = GenericResponseModel(status: ResponseStatus.failed);
    }
    return state;
  }

  (String, Map<String, dynamic>) getProfilePicture() {
    var profilePicture = (ItaApiUtils.profilePicture);
    var headers = ItaApiUtils.getOptions(ref).headers;
    return (profilePicture, headers);
  }
}
