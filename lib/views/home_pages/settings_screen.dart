import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/authentication/providers.dart';
import 'package:incident_tracker_app/ita_providers/common_providers.dart';
import 'package:incident_tracker_app/utils/_public_vars.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {

  changeLanguage() {
    var locale = context.locale;
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 7.0, 7.0),
                child:
                    Text(
                      "settings.changeLanguageModel.title",
                      style: Theme.of(context).textTheme.titleLarge,
                    ).tr(),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    languages
                        .map(
                          (e) => RadioListTile<String>(
                            title: Text("${e['name']}").tr(),
                            groupValue: "${e['code']}",
                            value: locale.languageCode,
                            onChanged: (l) async {
                              context.setLocale(e['locale'] as Locale);
                              Navigator.pop(context);
                            },
                            secondary: CircleAvatar(
                              backgroundImage: AssetImage("${e['icon']}"),
                              radius: 12,
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var version = ref.watch(versionProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListTile(
                title: Text(
                  "INCIDENT TRACKER",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              title: Text("settings.language").tr(),
              onTap: () {
                changeLanguage();
              },
              leading: Icon(Icons.language),
            ),
            ListTile(
              title: Text("settings.logout").tr(),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirm to logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text("Cancel"),
                        ),
                        Consumer(
                          builder: (context, ref, w) {
                            return TextButton(
                              onPressed: () {
                                ref.read(signInProvider.notifier).logout();
                                context.go("/login");
                              },
                              child: const Text("Logout"),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              leading: Icon(Icons.logout_outlined),
            ),
            Divider(height: 5),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "settings.version",
                style: const TextStyle(color: Colors.grey),
              ).tr(args: [version]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
