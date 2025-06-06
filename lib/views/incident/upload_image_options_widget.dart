import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/utils/custom_model_app_bar.dart';

class UploadImageOptionsWidget extends ConsumerStatefulWidget {
  const UploadImageOptionsWidget({super.key});

  @override
  ConsumerState<UploadImageOptionsWidget> createState() =>
      _UploadImageOptionsWidgetState();
}

class _UploadImageOptionsWidgetState
    extends ConsumerState<UploadImageOptionsWidget> {
  pickMainImage(bool fromGallery) async {
    // ref.read(imageProvider.notifier).state = null;
    // var result = await ref
    //     .read(uploadMainImageProvider.notifier)
    //     .pickMainImage(source: fromGallery ? "gallery" : "camera");
    // if (result != null) {
    //   ref.read(selectedFileProvider.notifier).state = result;
    // }
  }

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
                  onTap: () {
                    pickMainImage(true);
                    context.pop();
                  },
                ),
                ListTile(
                  title: const Text("Take a photo"),
                  onTap: () {
                    context.pop();
                    pickMainImage(false);
                  },
                  // onTap: () => selectImage(imageSource: ImageSource.camera),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
