import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/user_profile.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class UserProfileNotifier
    extends StateNotifier<GenericResponseModel<UserProfile>> {
  UserProfileNotifier(this.ref) : super(GenericResponseModel());
  Ref? ref;

  final storage = const FlutterSecureStorage();

  (String, Map<String, dynamic>) getProfilePicture() {
    var profilePicture = (ItaApiUtils.profilePicture);
    var headers = ItaApiUtils.getOptions(ref).headers;
    return (profilePicture, headers);
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
}
