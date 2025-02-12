import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notification = List.generate(20, (index) => "${index}h");

  void _onDismissed(DismissDirection direction, String notification) {
    print("Dismissed: $direction $notification");
    _notification.remove(notification);
    setState(() {});
    print("Notification: $_notification");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All activity"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Text(
              "New",
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Gaps.v14,
          for (var notification in _notification)
          Dismissible(
            key: Key(notification),
            onDismissed: (direction) => _onDismissed(
              direction,
              notification,
            ),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: FaIcon(
                  FontAwesomeIcons.checkDouble,
                  color: Colors.white,
                  size: Sizes.size32,
                ),
              ),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: FaIcon(
                  FontAwesomeIcons.trashCan,
                  color: Colors.white,
                  size: Sizes.size32,
                ),
              ),
            ),
            child: ListTile(
              minVerticalPadding: Sizes.size16,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              leading: Container(
                width: Sizes.size52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: FaIcon(FontAwesomeIcons.bell),
                ),
              ),
              title: RichText(
                text: TextSpan(
                    text: "Account updates:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: Sizes.size16,
                    ),
                    children: [
                      TextSpan(
                        text: " Upload longer videos",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: Sizes.size16,
                        ),
                      ),
                      TextSpan(
                        text: " $notification",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: Sizes.size16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ]),
              ),
              trailing: FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
