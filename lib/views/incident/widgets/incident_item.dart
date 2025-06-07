import 'package:flutter/material.dart';
import 'package:incident_tracker_app/models/create_incident.dart';

class IncidentItem extends StatelessWidget {
  final CreateIncident createIncident;
  final Function()? onTap;

  const IncidentItem({super.key, required this.createIncident, this.onTap});

  @override
  Widget build(BuildContext context) {
    var dataItem = createIncident;
    return ListTile(
      title: Text(
        dataItem.title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(dataItem.category),
      leading: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        decoration: BoxDecoration(
          color:
              dataItem.status == "Open"
                  ? Colors.green.withOpacity(.1)
                  : Colors.red.withOpacity(.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          dataItem.status == "Open"
              ? Icons.account_balance_wallet_outlined
              : Icons.account_balance_wallet_rounded,
          size: 20,
          color: dataItem.status == "Open" ? Colors.green : Colors.red,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dataItem.status,
            style: TextStyle(
              color: dataItem.status == "Open" ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            dataItem.dateTime.substring(0, 10),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
