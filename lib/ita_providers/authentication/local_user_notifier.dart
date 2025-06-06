import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:incident_tracker_app/models/local_user.dart' as localUser;
import 'package:incident_tracker_app/views/models/core_res.dart';

class LocalUserNotifier
    extends StateNotifier<GenericResponseModel<localUser.User>> {
  LocalUserNotifier(this.ref) : super(GenericResponseModel());
  Ref? ref;

  final storage = const FlutterSecureStorage();

  //Read user info from storage
  Future<GenericResponseModel<localUser.User>> autoLogin() async {
    var token = await storage.read(key: 'token');
    var user = await storage.read(key: 'user');
    if (token != null && user != null) {
      state = GenericResponseModel(status: ResponseStatus.loading);
      var auth = localUser.User.fromJson({
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
