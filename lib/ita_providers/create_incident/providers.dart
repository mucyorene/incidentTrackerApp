import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/create_incident_notifier.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/incident_details.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/upload_image_notifier.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';

var uploadProfileProvider = StateNotifierProvider<
  UploadImageNotifier,
  GenericResponseModel<PlatformFile>
>((ref) => UploadImageNotifier());
var selectedFileProvider = StateProvider<PlatformFile?>((ref) => null);
var createIncidentProvider = StateNotifierProvider<
  CreateIncidentNotifier,
  GenericResponseModel<CreateIncident>
>((ref) => CreateIncidentNotifier());
var incidentDetailsProvider = StateNotifierProvider<
  IncidentDetailsNotifier,
  GenericResponseModel<List<CreateIncident>>
>((ref) => IncidentDetailsNotifier());
