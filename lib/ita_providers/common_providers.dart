import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/authentication/sign_in_notifier.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/user_profile.dart' show UserProfile;

var authTokenProvider =
    StateNotifierProvider<SignInNotifier, GenericResponseModel<UserProfile>>(
      (ref) => SignInNotifier(ref),
    );
var profilePictureProvider =
    StateNotifierProvider<SignInNotifier, GenericResponseModel<UserProfile>>(
      (ref) => SignInNotifier(ref),
    );
