import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/videos/viewmodels/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: Text("Mute Videos"),
            subtitle: Text("Videos will be muted by default"),
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setMuted(value);
            },
          ),
          SwitchListTile.adaptive(
            title: Text("Auto Play"),
            subtitle: Text("Videos will play automatically"),
            value: ref.watch(playbackConfigProvider).autoPlay,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setAutoPlay(value);
            },
          ),
          CupertinoSwitch(
            value: false,
            onChanged: (value) {},
          ),
          Switch(
            value: false,
            onChanged: (value) {},
            activeColor: Colors.black,
          ),
          Checkbox(
            value: false,
            onChanged: (value) {},
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.black,
            value: false,
            onChanged: (value) {},
            title: Text("Notifications"),
          ),
          ListTile(
            onTap: () => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2030),
            ),
            title: Text("What is your birthday?"),
          ),
          ListTile(
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2021 TikTok Clone',
            ),
            title: Text(
              "About",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Version 1.0.0",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationName: 'TikTok Clone',
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2021 TikTok Clone',
          ),
          ListTile(
            title: Text("Log Out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Log Out"),
                    content: Text("Are you sure you want to log out?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoDialogAction(
                        child: Text("Log Out"),
                        onPressed: () => Navigator.pop(context),
                        isDestructiveAction: true,
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text("Log Out (Android)"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    icon: FaIcon(FontAwesomeIcons.skull),
                    title: Text("Log Out"),
                    content: Text("Are you sure you want to log out?"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: FaIcon(FontAwesomeIcons.close),
                      ),
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text("Log Out"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text("Log Out (iOS / Bottom Sheet)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return CupertinoActionSheet(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    actions: [
                      CupertinoActionSheetAction(
                        child: Text("Log Out"),
                        onPressed: () => Navigator.pop(context),
                        isDestructiveAction: true,
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
