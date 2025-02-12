import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

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
          ListTile(
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
                    text: " 1h",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: Sizes.size16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ]
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
