import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/create_incident/providers.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/models/create_incident.dart';
import 'package:incident_tracker_app/theme/styles.dart';
import 'package:incident_tracker_app/theme/theme.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/views/incident/upload_image_options_widget.dart';

class CreateIncidentScreen extends ConsumerStatefulWidget {
  const CreateIncidentScreen({super.key});

  @override
  ConsumerState<CreateIncidentScreen> createState() =>
      _CreateIncidentScreenState();
}

class _CreateIncidentScreenState extends ConsumerState<CreateIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final locationController = TextEditingController();
  final dateTimeController = TextEditingController();
  final statusController = TextEditingController();
  final photoController = TextEditingController();

  final selectedCategoryProvider = StateProvider<String?>((ref) => "");
  final selectedStatusProvider = StateProvider<String?>((ref) => "");

  validate() async {
    if (_formKey.currentState!.validate()) {
      var category = ref.read(selectedCategoryProvider);
      var status = ref.read(selectedCategoryProvider);
      var title = titleController.text;
      var description = descriptionController.text;
      var location = locationController.text;
      var dateTime = dateTimeController.text;
      var photo = ref.read(selectedFileProvider);

      var createIncident = CreateIncident(
        title: title,
        description: description,
        category: category ?? '',
        location: location,
        status: status ?? '',
        dateTime: dateTime,
        photo: photo?.path ?? "",
      );

      var info = await ref
          .read(createIncidentProvider.notifier)
          .createIncident(incident: createIncident);

      if (info.status == ResponseStatus.success) {
        Navigator.pop(context);
        showSnackBar(
          context,
          "Incident created successfully",
          status: ResponseStatus.success,
        );
      } else {
        showSnackBar(
          context,
          info.errorMessage,
          status: ResponseStatus.success,
        );
      }
    }
  }

  @override
  void initState() {
    ref.read(selectedFileProvider);
    super.initState();
  }

  var selectedFilesProvider = StateProvider<List<PlatformFile>>((ref) => []);

  pickMainImage(bool fromGallery) async {
    var result = await ref
        .read(uploadProfileProvider.notifier)
        .pickProfilePicture(source: fromGallery ? "gallery" : "camera");
    if (result != null) {
      ref.read(selectedFileProvider.notifier).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    var createProfileDetails = ref.watch(selectedFileProvider);
    var selectedStatus = ref.watch(selectedStatusProvider);
    var selectedCategory = ref.watch(selectedCategoryProvider);
    var createState = ref.watch(createIncidentProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Incident", style: TextStyle(color: Colors.white)),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLength: 25,
                                    validator: (s) {
                                      if (s == "") {
                                        return "Title is required";
                                      } else if ((s?.length ?? 0) < 2) {
                                        return "Text should be at least 2 characters";
                                      }
                                      return null;
                                    },
                                    controller: titleController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: "Write title",
                                      border: StyleUtils.commonInputBorder,
                                      enabledBorder:
                                          StyleUtils.commonEnabledInputBorder,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      maxLength: 250,
                                      maxLines: 3,
                                      validator: (s) {
                                        if (s == "") {
                                          return "Description is required";
                                        } else if ((s?.length ?? 0) < 10) {
                                          return "Description should be at least 10 characters";
                                        }
                                        return null;
                                      },
                                      controller: descriptionController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Write descriptions",
                                        border: StyleUtils.commonInputBorder,
                                        enabledBorder:
                                            StyleUtils.commonEnabledInputBorder,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    value:
                                        selectedCategory?.isNotEmpty == true
                                            ? selectedCategory
                                            : null,
                                    validator: (s) {
                                      if (s == null || s.isEmpty) {
                                        return "Category is required";
                                      }
                                      return null;
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        value: "High priority",
                                        child: Text("High priority"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Low priority",
                                        child: Text("Low priority"),
                                      ),
                                      DropdownMenuItem(
                                        value: "Priority",
                                        child: Text("Priority"),
                                      ),
                                    ],
                                    onChanged: (s) {
                                      ref
                                          .read(
                                            selectedCategoryProvider.notifier,
                                          )
                                          .state = s;
                                      categoryController.text = s ?? "";
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: "Select category",
                                      border: StyleUtils.commonInputBorder,
                                      enabledBorder:
                                          StyleUtils.commonEnabledInputBorder,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (s) {
                                        if (s == "") {
                                          return "Location is required";
                                        }
                                        return null;
                                      },
                                      controller: locationController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Write location",
                                        border: StyleUtils.commonInputBorder,
                                        enabledBorder:
                                            StyleUtils.commonEnabledInputBorder,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date & Time",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      controller: dateTimeController,
                                      keyboardType: TextInputType.text,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      readOnly: true,
                                      onTap: () async {
                                        var date = await showDatePicker(
                                          context: context,
                                          locale: context.locale,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2050),
                                        );
                                        if (date != null) {
                                          var time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (time != null) {
                                            DateTime selectedDateTime =
                                                DateTime(
                                                  date.year,
                                                  date.month,
                                                  date.day,
                                                  time.hour,
                                                  time.minute,
                                                );
                                            String formattedDateTime =
                                                DateFormat(
                                                  'yyyy-MM-dd HH:mm',
                                                ).format(selectedDateTime);
                                            dateTimeController.text =
                                                formattedDateTime;
                                          }
                                        }
                                      },
                                      validator: (s) {
                                        if (s == "") {
                                          return "Date and time are required";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Write date and time",
                                        border: StyleUtils.commonInputBorder,
                                        enabledBorder:
                                            StyleUtils.commonEnabledInputBorder,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Status",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      value:
                                          selectedStatus?.isNotEmpty == true
                                              ? selectedStatus
                                              : null,
                                      validator: (s) {
                                        if (s == "") {
                                          return "Select status";
                                        }
                                        return null;
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: "Open",
                                          child: Text("Open"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Closed",
                                          child: Text("Closed"),
                                        ),
                                      ],
                                      onChanged: (s) {
                                        ref
                                            .read(
                                              selectedStatusProvider.notifier,
                                            )
                                            .state = s;
                                        statusController.text = s ?? "";
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Select status",
                                        border: StyleUtils.commonInputBorder,
                                        enabledBorder:
                                            StyleUtils.commonEnabledInputBorder,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    var w = UploadImageOptionsWidget(
                                      selectSource: pickMainImage,
                                    );
                                    showWidgetDialog(
                                      MediaQuery.of(context).size.width,
                                      context,
                                      w,
                                    );
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(15),
                                    dashPattern: const [5, 5, 5],
                                    color: Colors.grey.withOpacity(.6),
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.cloud_upload_outlined),
                                              SizedBox(width: 20),
                                              Text("Upload images"),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "supported format .jpg .png .jpeg",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (createProfileDetails != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File("${createProfileDetails.path}"),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            ref.refresh(selectedFileProvider);
                                          },
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: errorRedColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: validate,
                                    style: StyleUtils.commonButtonStyle,
                                    child:
                                        createState.status ==
                                                ResponseStatus.saving
                                            ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              ),
                                            )
                                            : const Text(
                                              "Save",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 15,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
