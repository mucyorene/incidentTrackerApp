import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/theme/theme.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/views/incident/widgets/incident_details.dart'
    show IncidentDetails;
import 'package:incident_tracker_app/views/incident/widgets/incident_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(incidentsProvider.notifier).getIncidents();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var incidentDetails = ref.watch(incidentsProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () {
            return ref.read(incidentsProvider.notifier).getIncidents();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:
                    Text(
                      "pageContainer.incident",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
              ),
              SizedBox(height: 10),
              [ResponseStatus.loading].contains(incidentDetails.status)
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                    ],
                  )
                  : [ResponseStatus.empty].contains(incidentDetails.status)
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty_rounded,
                          size: 50,
                          color: primaryColor,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "There are no incidents added",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                  : [ResponseStatus.success].contains(incidentDetails.status)
                  ? ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (cxt, i) {
                      var dataItem = incidentDetails.data?[i];
                      return IncidentItem(
                        createIncident: dataItem!,
                        onTap: () {
                          var w = IncidentDetails(incident: dataItem);
                          showWidgetDialog(
                            MediaQuery.of(context).size.width,
                            context,
                            w,
                          );
                        },
                      );
                    },
                    separatorBuilder: (x, _) {
                      return SizedBox(height: 10);
                    },
                    itemCount: incidentDetails.data?.length ?? 0,
                  )
                  : Column(
                    children: [Center(child: Text("Another type of error"))],
                  ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          context.push("/createIncident");
        },
        backgroundColor: primaryColor,
        highlightElevation: 0.0,
        splashColor: primarySurfaceColor,
        child: Icon(Icons.add_outlined, color: Colors.white),
      ),
    );
  }
}
