import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class IncidentsNotifier
    extends StateNotifier<GenericResponseModel<List<CreateIncident>>> {
  IncidentsNotifier() : super(GenericResponseModel());
  Ref? ref;

  final instanceDb = Hive.box<CreateIncident>('incidentDb');

  Future<GenericResponseModel<List<CreateIncident>>> getIncidents() async {
    state = GenericResponseModel(status: ResponseStatus.loading);
    try {
      final incidents = instanceDb.values.toList();

      final sortedIncidents = incidents.reversed.toList();

      state = GenericResponseModel(
        status:
            sortedIncidents.isEmpty
                ? ResponseStatus.empty
                : ResponseStatus.success,
        data: sortedIncidents,
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

  Future<GenericResponseModel<List<CreateIncident>>> deleteIncident({
    required String incident,
  }) async {
    state = GenericResponseModel(status: ResponseStatus.saving);
    try {
      final itemToDelete = instanceDb.keys.firstWhere(
        (key) => instanceDb.get(key)?.title == incident,
        orElse: () => null,
      );

      if (itemToDelete != null) {
        await instanceDb.delete(itemToDelete);
      }
      final updatedItems = instanceDb.values.toList();

      state = GenericResponseModel(
        status: ResponseStatus.success,
        data: updatedItems,
        message: "Incident deleted successfully",
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
}
