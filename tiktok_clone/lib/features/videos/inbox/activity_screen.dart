import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notification = List.generate(20, (index) => "${index}h");

  bool _showBarrier = false;

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    },
  ];

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 1000),
  );

  late final Animation<double> _arrowAnimation =
      Tween<double>(begin: 0.0, end: 0.5).animate(
    _animationController,
  );

  late final Animation<Offset> _panelAnimation = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset.zero,
  ).animate(
    _animationController,
  );

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(
    _animationController,
  );

  void _onDismissed(DismissDirection direction, String notification) {
    print("Dismissed: $direction $notification");
    _notification.remove(notification);
    setState(() {});
    print("Notification: $_notification");
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    print("Show Barrier before: $_showBarrier");
    setState(() {
      _showBarrier = !_showBarrier;
    });
    print("Show Barrier after: $_showBarrier");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("All activity "),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView(
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
          if (_showBarrier)
          AnimatedModalBarrier(
            color: _barrierAnimation,
            dismissible: true,
            onDismiss: _toggleAnimations,
          ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size20),
                  bottomRight: Radius.circular(Sizes.size20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
