import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  var versionProvider = StateProvider((ref) => "");

  getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    ref.read(versionProvider.notifier).state = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    var version = ref.watch(versionProvider);
    return Scaffold(
      backgroundColor: primarySurfaceColor,
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(color: primarySurfaceColor)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text("v$version", style: TextStyle(color: primaryColor)),
            ),
          ),
          Positioned(
            right: -200,
            child: Transform.rotate(
              angle: 101.4,
              child: SizedBox(
                width: 400,
                height: 340,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "ITracker",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: primaryColor,
              ),
            ),
          ),
          Positioned(
            left: -150,
            top: 600,
            child: Transform.rotate(
              angle: 100.1,
              child: SizedBox(
                width: 220,
                height: 450,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(80),
                      bottomLeft: Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
