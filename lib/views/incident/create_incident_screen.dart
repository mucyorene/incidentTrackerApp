import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/theme/styles.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

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

  validate() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
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
                                    validator: (s) {
                                      if (s == "") {
                                        return "Title is required";
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
                                        } else if ((s?.length ?? 0) < 3) {
                                          return "Description should be at least 3 characters";
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
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    readOnly: true,
                                    validator: (s) {
                                      if (s == "") {
                                        return "Category is required";
                                      }
                                      return null;
                                    },
                                    controller: categoryController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
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
                                      keyboardType: TextInputType.text,
                                      readOnly: true,
                                      validator: (s) {
                                        if (s == "") {
                                          return "Date and time are required";
                                        }
                                        return null;
                                      },
                                      controller: dateTimeController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                    SizedBox(height: 8),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      readOnly: true,
                                      validator: (s) {
                                        if (s == "") {
                                          return "Select status";
                                        }
                                        return null;
                                      },
                                      controller: statusController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
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
                                    var w = SafeArea(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Upload profile picture",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
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
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: validate,
                                    style: StyleUtils.commonButtonStyle,
                                    child:
                                    // createState.status ==
                                    //         ResponseStatus.saving
                                    //     ? const SizedBox(
                                    //       height: 20,
                                    //       width: 20,
                                    //       child: CircularProgressIndicator(
                                    //         backgroundColor: Colors.white,
                                    //       ),
                                    //     )
                                    //     :
                                    const Text(
                                      "Login",
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
