import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:image_picker/image_picker.dart';

class CreateIncidentNotifier extends StateNotifier<GenericResponseModel> {
  CreateIncidentNotifier() : super(GenericResponseModel());
  Ref? ref;

  Future<PlatformFile?> pickMainImage({String source = "camera"}) async {
    try {
      if (source == "camera") {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          final PlatformFile platformFile = PlatformFile(
            name: image.name,
            size: await image.length(),
            path: image.path,
          );
          if (platformFile.size > 10000000) {
            state = GenericResponseModel(message: "Too big file", data: null);
          } else {
            state = GenericResponseModel(message: null, data: platformFile);
            return platformFile;
          }
        }
      } else {
        FilePickerResult? filePickerResult;
        filePickerResult = await FilePicker.platform.pickFiles(
          type: FileType.image,
          // allowedExtensions: ["jpeg", "png", "jpg"],
          allowMultiple: false,
          dialogTitle: "Select an image",
          withData: true,
        );
        if (filePickerResult != null && filePickerResult.files.isNotEmpty) {
          final pickedFile = filePickerResult.files.first;
          if (pickedFile.size > 10 * 1024 * 1024) {
            state = GenericResponseModel(
              message: "File too large (max 10MB)",
              data: null,
            );
            return null;
          }

          final validExtensions = ["jpeg", "png", "jpg"];

          final fileExtension = pickedFile.extension?.toLowerCase();
          if (fileExtension == null ||
              !validExtensions.contains(fileExtension)) {
            state = GenericResponseModel(
              message: "Invalid file type (only JPEG/PNG allowed)",
              data: null,
            );
            return null;
          }
          state = GenericResponseModel(message: null, data: pickedFile);
          return pickedFile;
        }
      }
    } catch (e) {
      state = GenericResponseModel(
        message: "Failed to pick image: ${e.toString()}",
        data: null,
      );
    }
    return null;
  }
}
