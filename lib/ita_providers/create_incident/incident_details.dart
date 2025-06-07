import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class IncidentDetailsNotifier
    extends StateNotifier<GenericResponseModel<List<CreateIncident>>> {
  IncidentDetailsNotifier() : super(GenericResponseModel());
  Ref? ref;

  final storage = const FlutterSecureStorage();

  Future<GenericResponseModel<List<CreateIncident>>>
  getIncidentDetails() async {
    state = GenericResponseModel(status: ResponseStatus.loading);
    try {
      var incident = await storage.read(key: 'incident');
      print("HERE IS INCIDENT: $incident");
      if (incident != null) {
        List<CreateIncident> items = [];
        var incidentData = CreateIncident.fromJson(jsonDecode(incident));
        items.add(incidentData);
        state = GenericResponseModel(
          status: ResponseStatus.success,
          data: items,
        );
      } else {
        state = GenericResponseModel(status: ResponseStatus.failed);
      }
      return state;
    } on DioException catch (e) {
      state = ItaApiUtils.catchDioException(e);
      return state;
    } catch (e) {
      state = ItaApiUtils.catchException(e);
      return state;
    }
  }
}
