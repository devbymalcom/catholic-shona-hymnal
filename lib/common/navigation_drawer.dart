import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'linked_label_radio.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  static const values = <String>['Light', 'Dark', 'System'];
  String selectedValue = values.last;

  final selectedColor = Colors.green;
  final unselectedColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Hymnal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            minVerticalPadding: 0,
            minLeadingWidth: 35,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            horizontalTitleGap: 0,
            tileColor: Color(0xFFEFF4FF),
            title: const Text('All Hymns', style: TextStyle()),
            leading: Icon(Icons.queue_music),
            onTap: () => onItemPressed(context, index: 0),
          ),
          ListTile(
            minVerticalPadding: 0,
            minLeadingWidth: 35,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            horizontalTitleGap: 0,
            title: const Text('Favorite Hymns', style: TextStyle()),
            leading: Icon(Icons.queue_music),
            onTap: () => onItemPressed(context, index: 2),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            minVerticalPadding: 0,
            minLeadingWidth: 35,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            horizontalTitleGap: 0,
            title: const Text(
              'Dzimbo Sande',
            ),
            leading: Icon(Icons.queue_music),
            onTap: () => onItemPressed(context, index: 2),
          ),
          ListTile(
            minVerticalPadding: 0,
            minLeadingWidth: 35,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            horizontalTitleGap: 0,
            title: Text(
              'Dzimbo Nenguva',
            ),
            leading: Icon(Icons.queue_music),
            onTap: () => onItemPressed(context, index: 2),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Miscellenous',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            minVerticalPadding: 0,
            minLeadingWidth: 35,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            horizontalTitleGap: 0,
            title: Text(
              'Choose Theme',
            ),
            leading: Icon(Icons.brightness_4),
            onTap: () => onItemPressed(context, index: 1),
          ),
          ListTile(
            minVerticalPadding: 0,
            minLeadingWidth: 35,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            horizontalTitleGap: 0,
            title: Text(
              'Help and feedback',
            ),
            leading: Icon(Icons.help_outline),
            onTap: () => onItemPressed(context, index: 2),
          ),
        ]),
      ),
    );
  }

  void onItemPressed(BuildContext context, {int? index}) {
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        _dialogBuilder(context);

        break;
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Consumer<ThemeProvider>(builder: (context, provider, child) {
          return AlertDialog(
            title: const Text('Choose Theme'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: values.map((value) {
                return LinkedLabelRadio(
                  label: value,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: value,
                  groupValue: selectedValue,
                  onChanged: (String newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                );
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Hymn()));
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('OK'),
                onPressed: () {
                  provider.changeTheme(selectedValue) ?? 'System';
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HymnalScreen()));
                },
              ),
            ],
          );
        });
      }),
    );
  }
}
