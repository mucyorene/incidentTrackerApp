import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class IncidentsNotifier
    extends StateNotifier<GenericResponseModel<List<CreateIncident>>> {
  IncidentsNotifier() : super(GenericResponseModel());
  Ref? ref;

  final storage = const FlutterSecureStorage();

  Future<GenericResponseModel<List<CreateIncident>>> getIncidents() async {
    state = GenericResponseModel(status: ResponseStatus.loading);
    try {
      var incident = await getItems();
      var items = List<CreateIncident>.from(
        incident.map((e) => CreateIncident.fromJson(e)),
      );
      state = GenericResponseModel(
        status: items.isEmpty ? ResponseStatus.empty : ResponseStatus.success,
        data: items.reversed.toList(),
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
      List<Map<String, dynamic>> items = await getItems();
      if ((items.where((element) => element['title'] == incident)).isNotEmpty) {
        items.removeWhere((element) => element['title'] == incident);
        await storage.write(key: 'incident', value: jsonEncode(items));
      }
      var items2 = List<CreateIncident>.from(
        items.map((e) => CreateIncident.fromJson(e)),
      );
      state = GenericResponseModel(
        status: ResponseStatus.success,
        data: items2,
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

  Future<List<Map<String, dynamic>>> getItems() async {
    String? data = await storage.read(key: 'incident');
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    return [];
  }
}
