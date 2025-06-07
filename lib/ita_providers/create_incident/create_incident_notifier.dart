import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart'
    show incidentsProvider;
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class CreateIncidentNotifier
    extends StateNotifier<GenericResponseModel<CreateIncident>> {
  CreateIncidentNotifier() : super(GenericResponseModel());
  Ref? ref;

  final instanceDb = Hive.box<CreateIncident>("incidentDb");

  Future<GenericResponseModel<CreateIncident>> createIncident({
    required CreateIncident incident,
  }) async {
    state = GenericResponseModel(status: ResponseStatus.saving);
    try {
      final existing = instanceDb.values.any((e) => e.title == incident.title);
      if (!existing) {
        await instanceDb.add(incident);
      }

      state = GenericResponseModel(
        status: ResponseStatus.success,
        statusCode: 200,
      );

      ref?.read(incidentsProvider.notifier).getIncidents();
      return state;
    } on DioException catch (e) {
      state = ItaApiUtils.catchDioException(e);
      return state;
    } catch (e) {
      state = ItaApiUtils.catchException(e);
      return state;
    }
  }

  Future<GenericResponseModel<CreateIncident>> editIncident({
    required String title,
    required CreateIncident incident,
  }) async {
    state = GenericResponseModel(status: ResponseStatus.saving);
    try {
      final key = instanceDb.keys.firstWhere(
        (e) => instanceDb.get(e)?.title == title,
        orElse: () => null,
      );

      if (key != null) {
        await instanceDb.put(key, incident);
        state = GenericResponseModel(
          status: ResponseStatus.success,
          statusCode: 200,
        );
        ref?.read(incidentsProvider.notifier).getIncidents();
      } else {
        state = GenericResponseModel(
          status: ResponseStatus.failed,
          message: "Incident not found",
        );
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
