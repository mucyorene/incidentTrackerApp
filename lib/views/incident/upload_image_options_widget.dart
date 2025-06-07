import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/utils/custom_model_app_bar.dart';

class UploadImageOptionsWidget extends ConsumerStatefulWidget {
  final Function selectSource;

  const UploadImageOptionsWidget({super.key, required this.selectSource});

  @override
  ConsumerState<UploadImageOptionsWidget> createState() =>
      _UploadImageOptionsWidgetState();
}

class _UploadImageOptionsWidgetState
    extends ConsumerState<UploadImageOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: customAppbar(
                context,
                "Upload profile picture",
                onClose: () {},
              ),
            ),
            Divider(height: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text("Upload from your device"),
                  leading: Icon(Icons.image_sharp),
                  onTap: () {
                    widget.selectSource(true);
                    context.pop();
                  },
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: const Text("Take a photo"),
                  leading: Icon(Icons.camera_alt_outlined),
                  onTap: () {
                    context.pop();
                    widget.selectSource(false);
                  },
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
