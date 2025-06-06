import 'package:flutter/material.dart';

typedef OnButtonClick = Function();

AppBar customAppbar(
  BuildContext context,
  String title, {
  OnButtonClick? onClose,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(title),
    actions: [
      IconButton(
        onPressed:
            onClose == null
                ? null
                : () {
                  Navigator.pop(context);
                  onClose();
                },
        icon: const Icon(Icons.close_rounded),
        splashRadius: 22,
      ),
    ],
    iconTheme: const IconThemeData.fallback(),
    titleTextStyle: Theme.of(context).textTheme.titleLarge,
    centerTitle: false,
    primary: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );
}
