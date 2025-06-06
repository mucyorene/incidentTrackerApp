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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(title: Text("Language")),
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
