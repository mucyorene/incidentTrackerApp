import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/views/models/core_res.dart';

class SignInNotifier extends StateNotifier<GenericResponseModel> {
  SignInNotifier(this.ref) : super(GenericResponseModel());
  Ref? ref;

}
