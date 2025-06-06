import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/authentication/local_user_notifier.dart';
import 'package:incident_tracker_app/models/local_user.dart' as localUser;
import 'package:incident_tracker_app/views/models/core_res.dart';

var authTokenProvider = StateNotifierProvider<
  LocalUserNotifier,
  GenericResponseModel<localUser.User>
>((ref) => LocalUserNotifier(ref));
var profilePictureProvider = StateNotifierProvider<
  LocalUserNotifier,
  GenericResponseModel<localUser.User>
>((ref) => LocalUserNotifier(ref));
