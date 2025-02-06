import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/main_navigation/main_navigation_screen.dart';

enum Direction {
  up,
  down,
}

enum Page {
  first,
  second,
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.down;
  Page _page = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    print(details);
    // 아래로 스크롤 시 이전 페이지로 이동
    if (details.delta.dy > 0) {
      setState(() {
        _direction = Direction.down;
      });
    } else if (details.delta.dy < 0) {
      // 위로 스크롤 시 다음 페이지로 이동
      setState(() {
        _direction = Direction.up;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.down) {
      setState(() {
        _page = Page.first;
      });
    } else {
      setState(() {
        _page = Page.second;
      });
    }
  }

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(),
      ),
      (route) {
        print(route);
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: TutorialPageOne(),
              secondChild: TutorialPageTwo(),
              crossFadeState: _page == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(
                milliseconds: 300,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: Sizes.size60 * 2,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _page == Page.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: _onEnterAppTap,
                autofocus: true,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Enter the app!',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutorialPageTwo extends StatelessWidget {
  const TutorialPageTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v36,
        Text(
          "Follow the rules!",
          style: TextStyle(
            fontSize: Sizes.size40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v20,
        Text(
          "Videos are personalized for you based on what you watch, like, and share.",
          style: TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}

class TutorialPageOne extends StatelessWidget {
  const TutorialPageOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v36,
        Text(
          "Match cool videos!",
          style: TextStyle(
            fontSize: Sizes.size40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.v20,
        Text(
          "Videos are personalized for you based on what you watch, like, and share.",
          style: TextStyle(
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
