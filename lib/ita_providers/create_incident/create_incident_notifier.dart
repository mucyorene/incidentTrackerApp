import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart'
    show incidentsProvider;
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
      List<Map<String, dynamic>> items = await getItems();
      if ((items.where(
        (element) => element['title'] == incident.title,
      )).isEmpty) {
        items = [...items, incident.toJson()];
        await storage.write(key: 'incident', value: jsonEncode(items));
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
      List<Map<String, dynamic>> items = await getItems();

      items =
          items.map((item) {
            if (item['title'] == title) {
              return incident.toJson(); // Replace with updated one
            }
            return item;
          }).toList();
      await storage.write(key: 'incident', value: jsonEncode(items));

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

  Future<List<Map<String, dynamic>>> getItems() async {
    String? data = await storage.read(key: 'incident');
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    return [];
  }
}
