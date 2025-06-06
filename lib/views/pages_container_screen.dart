import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:incident_tracker_app/views/home_pages/home_screen.dart';
import 'package:incident_tracker_app/views/home_pages/profile_screen.dart';
import 'package:incident_tracker_app/views/home_pages/settings_screen.dart';

class PagesContainerScreen extends ConsumerStatefulWidget {
  const PagesContainerScreen({super.key});

  @override
  ConsumerState<PagesContainerScreen> createState() =>
      _PagesContainerScreenState();
}

class _PagesContainerScreenState extends ConsumerState<PagesContainerScreen> {
  var activePageProvider = StateProvider<int>((ref) => 0);
  var page = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var currentPage = ref.watch(activePageProvider);
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        onPageChanged: (i) {
          ref.read(activePageProvider.notifier).state = i;
        },
        controller: pageController,
        children: [HomeScreen(), ProfileScreen(), SettingsScreen()],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          currentIndex: currentPage,
          onTap: (s) {
            pageController.animateToPage(
              s,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "pageContainer.home".tr(),
              activeIcon: Icon(Icons.dashboard_rounded),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined),
              activeIcon: Icon(Icons.person_3_rounded),
              label: "pageContainer.profile".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings_rounded),
              label: "pageContainer.settings".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
