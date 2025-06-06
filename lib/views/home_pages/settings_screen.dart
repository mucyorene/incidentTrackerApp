import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              onTap: () {},
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
