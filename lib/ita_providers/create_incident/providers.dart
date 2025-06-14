import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/create_incident_notifier.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/incidents.dart';
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

var incidentsProvider = StateNotifierProvider<
  IncidentsNotifier,
  GenericResponseModel<List<CreateIncident>>
>((ref) => IncidentsNotifier());

var deleteIncidentProvider = StateNotifierProvider<
  IncidentsNotifier,
  GenericResponseModel<List<CreateIncident>>
>((ref) => IncidentsNotifier());
