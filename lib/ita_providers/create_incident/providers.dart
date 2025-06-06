import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/upload_image_notifier.dart';
import 'package:incident_tracker_app/models/core_res.dart';

var uploadProfileProvider = StateNotifierProvider<
  UploadImageNotifier,
  GenericResponseModel<PlatformFile>
>((ref) => UploadImageNotifier());
var selectedFileProvider = StateProvider<PlatformFile?>((ref) => null);
