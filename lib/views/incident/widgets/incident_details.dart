import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/views/incident/create_incident_screen.dart';

class IncidentDetails extends ConsumerStatefulWidget {
  final CreateIncident incident;

  const IncidentDetails({super.key, required this.incident});

  @override
  ConsumerState<IncidentDetails> createState() => _IncidentDetailsState();
}

class _IncidentDetailsState extends ConsumerState<IncidentDetails> {
  confirmDeleteRecord(String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm delete"),
          content: const Text("Are you sure you want to delete this incident?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteRecord(title);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  deleteRecord(String title) async {
    var info = await ref
        .read(deleteIncidentProvider.notifier)
        .deleteIncident(incident: title);

    if (info.statusCode == 200) {
      ref.read(incidentsProvider.notifier).getIncidents();
      showSnackBar(
        context,
        "${info.message}",
        status: info.status,
        statusCode: info.statusCode,
      );
      Navigator.pop(context);
    } else {
      showSnackBar(
        context,
        "${info.message}",
        status: ResponseStatus.failed,
        statusCode: info.statusCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Row(
                children: [
                  Text(
                    widget.incident.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      var w = CreateIncidentScreen(
                        incidentTitle: widget.incident.title,
                      );
                      Navigator.pop(context);
                      showWidgetDialog(
                        MediaQuery.of(context).size.width,
                        context,
                        w,
                      );
                    },
                    child: Icon(Icons.edit_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Title"),
                    contentPadding: EdgeInsets.zero,
                    subtitle: Text(widget.incident.title),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            widget.incident.status == "Open"
                                ? Colors.green.withOpacity(.1)
                                : Colors.red.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        widget.incident.status,
                        style: TextStyle(
                          color:
                              widget.incident.status == "Open"
                                  ? Colors.green
                                  : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Category"),
                    contentPadding: EdgeInsets.zero,
                    subtitle: Text(widget.incident.category),
                  ),
                  ListTile(
                    title: Text("Description"),
                    contentPadding: EdgeInsets.zero,
                    subtitle: Text(widget.incident.description),
                  ),
                  ListTile(
                    title: Text("Location"),
                    contentPadding: EdgeInsets.zero,
                    subtitle: Text(widget.incident.location),
                  ),
                  ListTile(
                    title: Text(
                      "Delete incident",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      confirmDeleteRecord(widget.incident.title);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
