import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/common_providers.dart';
import 'package:incident_tracker_app/views/models/core_res.dart';

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
      init();
    });
    super.initState();
  }

  init() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      var info = ref.read(authTokenProvider);

      if (info.status == ResponseStatus.success) {
        context.go("/homepage");
      } else {
        context.go("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Center(child: Text("ITracker")),
        ],
      ),
    );
  }
}
