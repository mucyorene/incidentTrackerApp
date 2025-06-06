import 'package:extended_image/extended_image.dart' show ExtendedImage;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<void> _launch(Uri url) async {
    try {
      if (!await launchUrl(url)) {
        throw 'Could not launch';
      }
    } catch (e) {
      // showSnackBar(context, "Can not perform this action",
      //     status: ResponseStatus.completed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [];
          },
          body: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Builder(
                      builder: (context) {
                        return ExtendedImage.network(
                          "https://img.freepik.com/premium-vector/character-avatar-isolated_729149-194801.jpg?semt=ais_hybrid&w=740",
                          // headers: Map<String, String>.from(headers),
                          fit: BoxFit.cover,
                          shape: BoxShape.circle,
                          cache: true,
                          width: 150,
                          height: 150,
                          cacheMaxAge: const Duration(minutes: 10),
                          gaplessPlayback: true,
                          clearMemoryCacheWhenDispose: true,
                          loadStateChanged: (state) {
                            return CircleAvatar();
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    "Rene MUCYO TUYISENGE",
                    style: const TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'renemucyo1@gmail.com',
                          );
                          _launch(emailLaunchUri);
                        },
                        // detailsState.data?.email == null
                        //         ? null
                        //         : () {
                        //           final Uri emailLaunchUri = Uri(
                        //             scheme: 'mailto',
                        //             path: 'renemucyo1@gmail.com',
                        //           );
                        //           _launch(emailLaunchUri);
                        //         },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: errorInfoColor,
                            // backgroundColor:
                            //     detailsState.data?.email == null
                            //         ? Colors.grey.shade300
                            //         : null,
                            child: Icon(
                              Icons.alternate_email_rounded,
                              size: 18,
                              color: Colors.white,
                              // color:
                              //     detailsState.data?.email == null
                              //         ? Colors.grey
                              //         : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          final Uri smsLaunchUri = Uri(
                            scheme: 'sms',
                            path: '+250784494820',
                          );
                          _launch(smsLaunchUri);
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundColor: thirdColor,
                            // backgroundColor:
                            // detailsState.data?.phoneNumber == null
                            //     ? Colors.grey.shade300
                            //     : thirdColor,
                            radius: 23,
                            child: Icon(
                              Icons.comment_rounded,
                              size: 18,
                              color: Colors.white,
                              // color:
                              //     detailsState.data?.phoneNumber == null
                              //         ? Colors.grey
                              //         : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          final Uri smsLaunchUri = Uri(scheme: 'tel', path: '');
                          _launch(smsLaunchUri);
                        },
                        // detailsState.data?.phoneNumber == null
                        //         ? null
                        //         : () {
                        //           final Uri smsLaunchUri = Uri(
                        //             scheme: 'tel',
                        //             path: '${detailsState.data?.phoneNumber}',
                        //           );
                        //           _launch(smsLaunchUri);
                        //         },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundColor: greenColor,
                            // detailsState.data?.phoneNumber == null
                            //     ? Colors.grey.shade300
                            //     : greenColor,
                            radius: 23,
                            child: Icon(
                              Icons.phone,
                              size: 18,
                              color: Colors.white,
                              // color:
                              //     detailsState.data?.phoneNumber == null
                              //         ? Colors.grey
                              //         : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PERSONAL INFO",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Full names"),
                    subtitle: Text("Rene MUCYO TUYISENGE"),
                    leading: Icon(Icons.ac_unit),
                  ),
                  const Divider(height: 5),
                  ListTile(
                    title: Text("Account type"),
                    subtitle: Text("Super"),
                    leading: Icon(Icons.account_balance_wallet),
                  ),
                  const Divider(height: 5),
                  ListTile(
                    title: Text("Gender"),
                    subtitle: Text("Male"),
                    leading: Icon(Icons.generating_tokens_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "CONTACT INFO",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Phone"),
                    subtitle: Text("+250784494820"),
                    leading: Icon(Icons.phone_in_talk_rounded),
                  ),
                  const Divider(height: 5),
                  ListTile(
                    title: Text("Email"),
                    subtitle: Text("renemucyo1@gmail.com"),
                    leading: Icon(Icons.email_outlined),
                  ),
                  ListTile(
                    title: Text(
                      "Delete profile",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onTap: () {
                      // confirmDelete();
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
