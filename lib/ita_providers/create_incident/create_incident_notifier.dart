import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class CreateIncidentNotifier
    extends StateNotifier<GenericResponseModel<CreateIncident>> {
  CreateIncidentNotifier() : super(GenericResponseModel());
  Ref? ref;

  final storage = const FlutterSecureStorage();

  Future<GenericResponseModel<CreateIncident>> createIncident({
    required CreateIncident incident,
  }) async {
    state = GenericResponseModel(status: ResponseStatus.saving);
    try {
      await storage.write(
        key: 'incident',
        value: jsonEncode(incident.toJson()),
      );
      state = GenericResponseModel(
        status: ResponseStatus.success,
        statusCode: 200,
      );
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
