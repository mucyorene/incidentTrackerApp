import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/common_providers.dart';
import 'package:incident_tracker_app/ita_providers/profile/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/theme/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authTokenProvider.notifier).autoLogin();
      getVersion();
      init();
    });
    super.initState();
  }

  init() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      var info = ref.read(authTokenProvider);
      if (info.status == ResponseStatus.success) {
        var userState = info.data;
        if (userState?.token != null) {
          context.go("/homepage");
        }
      } else {
        context.go("/login");
      }
    });
  }

  getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    ref.read(versionProvider.notifier).state = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    var version = ref.watch(versionProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "v$version",
                style: TextStyle(color: primaryColor, fontSize: 15),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/qt_logo.jpg',
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
        ],
      ),
    );
  }
}
