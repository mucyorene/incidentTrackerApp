import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/theme/theme.dart';

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
    print("HERE IS STATUS: ${incidentDetails.status}");
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () {
            return ref.read(incidentsProvider.notifier).getIncidents();
          },
          child:
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
                    shrinkWrap: true,
                    itemBuilder: (cxt, i) {
                      var dataItem = incidentDetails.data?[i];
                      return ListTile(
                        title: Text(dataItem?.title ?? ""),
                        subtitle: Text(dataItem?.dateTime ?? "-"),
                        trailing: Text(dataItem?.status ?? "-"),
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
