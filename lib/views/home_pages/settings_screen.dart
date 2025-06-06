import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/authentication/providers.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  var versionProvider = StateProvider((ref) => "");

  getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    ref.read(versionProvider.notifier).state = packageInfo.version;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getVersion();
    });
    super.initState();
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
              title: Text("Language"),
              onTap: () {},
              leading: Icon(Icons.language),
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Sign in again"),
                      // title: const Text("Session expired"),
                      content: const Text(
                        "You need to sign in, after session expiration",
                      ),
                      // content: const Text("You are required to sign in again into your account"),
                      actions: [
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
            Text(
              "Version: $version",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
