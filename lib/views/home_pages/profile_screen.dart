import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart'
    show ExtendedImage, LoadState;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/ita_providers/profile/providers.dart';
import 'package:incident_tracker_app/theme/theme.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';
import 'package:incident_tracker_app/models/core_res.dart';
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
      showSnackBar(
        context,
        "Can not perform this action",
        status: ResponseStatus.completed,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authTokenProvider);
    var profilePicture =
        ref.read(profilePictureProvider.notifier).getProfilePicture();
    return Scaffold(
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
                    child: ExtendedImage.network(
                      profilePicture.$1,
                      headers: Map<String, String>.from(profilePicture.$2),
                      fit: BoxFit.cover,
                      shape: BoxShape.circle,
                      cache: true,
                      width: 150,
                      height: 150,
                      cacheMaxAge: const Duration(minutes: 10),
                      gaplessPlayback: true,
                      clearMemoryCacheWhenDispose: false,
                      loadStateChanged: (state) {
                        if (state.extendedImageLoadState == LoadState.failed) {
                          return Icon(Icons.person_3_rounded, size: 20);
                        }
                        return null;
                      },
                    ),
                  ),
                  Text(
                    "${userState.data?.user.firstName ?? "-"} ${userState.data?.user.lastName ?? "-"}",
                    style: const TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:
                            userState.data?.user.email == null
                                ? null
                                : () {
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: userState.data?.user.email ?? "-",
                                  );
                                  _launch(emailLaunchUri);
                                },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor:
                                userState.data?.user.email == null
                                    ? Colors.grey.shade300
                                    : errorInfoColor,
                            child: Icon(
                              Icons.alternate_email_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          final Uri smsLaunchUri = Uri(
                            scheme: 'sms',
                            path: '${userState.data?.user.phone}',
                          );
                          _launch(smsLaunchUri);
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundColor: thirdColor,
                            radius: 23,
                            child: Icon(
                              Icons.comment_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap:
                            userState.data?.user.phone == null
                                ? null
                                : () {
                                  final Uri smsLaunchUri = Uri(
                                    scheme: 'tel',
                                    path: '${userState.data?.user.phone}',
                                  );
                                  _launch(smsLaunchUri);
                                },
                        borderRadius: BorderRadius.circular(25),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundColor:
                                userState.data?.user.phone == null
                                    ? Colors.grey.shade300
                                    : greenColor,
                            radius: 23,
                            child: Icon(
                              Icons.phone,
                              size: 18,
                              color:
                                  userState.data?.user.phone == null
                                      ? Colors.grey
                                      : Colors.white,
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
                          "profileScreen.personalInfo.title",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("profileScreen.personalInfo.fullNames").tr(),
                    subtitle: Text(
                      "${userState.data?.user.firstName} ${userState.data?.user.lastName}",
                    ),
                    leading: Icon(Icons.ac_unit),
                  ),
                  const Divider(height: 5),
                  ListTile(
                    title: Text("profileScreen.personalInfo.accountType").tr(),
                    subtitle: Text(userState.data?.user.accountType ?? "-"),
                    leading: Icon(Icons.account_balance_wallet),
                  ),
                  const Divider(height: 5),
                  ListTile(
                    title: Text("profileScreen.personalInfo.gender").tr(),
                    subtitle: Text(userState.data?.user.gender ?? "-"),
                    leading: Icon(Icons.generating_tokens_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "profileScreen.contactInfo.title",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("profileScreen.contactInfo.phone").tr(),
                    subtitle: Text(userState.data?.user.phone ?? "-"),
                    leading: Icon(Icons.phone_in_talk_rounded),
                  ),
                  const Divider(height: 5),
                  ListTile(
                    title: Text("profileScreen.contactInfo.email").tr(),
                    subtitle: Text(userState.data?.user.email ?? "-"),
                    leading: Icon(Icons.email_outlined),
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
