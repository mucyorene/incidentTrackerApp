import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/models/user_profile.dart';
import 'package:incident_tracker_app/views/ita_providers/authentication/sign_in_notifier.dart';
import 'package:incident_tracker_app/views/models/core_res.dart';

var signInProvider =
    StateNotifierProvider<SignInNotifier, GenericResponseModel<LoginResponse>>(
      (ref) => SignInNotifier(ref),
    );
