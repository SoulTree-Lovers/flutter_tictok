import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/inbox/chats_screen.dart';

import 'activity_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  void _onDmPressed() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ChatsScreen(),
    //   ),
    // );
    context.pushNamed(
      ChatsScreen.routeName,
    );
  }

  void _onActivityTap() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ActivityScreen(),
    //   ),
    // );
    context.pushNamed(
      ActivityScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
        actions: [
          IconButton(
            onPressed: _onDmPressed,
            icon: FaIcon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: _onActivityTap,
            title: Text(
              "Activity",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.black,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              "New followers",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: Text(
              "See who followed you",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
