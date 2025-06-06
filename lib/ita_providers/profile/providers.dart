import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/profile/user_profile_notifier.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/user_profile.dart' show UserProfile;

var authTokenProvider = StateNotifierProvider<
  UserProfileNotifier,
  GenericResponseModel<UserProfile>
>((ref) => UserProfileNotifier(ref));
var profilePictureProvider = StateNotifierProvider<
  UserProfileNotifier,
  GenericResponseModel<UserProfile>
>((ref) => UserProfileNotifier(ref));
