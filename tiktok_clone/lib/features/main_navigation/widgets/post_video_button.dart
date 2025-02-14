import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/utils/utils.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  final bool inverted;

  const PostVideoButton({
    super.key,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: Sizes.size20,
          child: Container(
            height: Sizes.size40,
            width: Sizes.size28,
            padding: EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
              color: Color(0xFF61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size12),
            ),
          ),
        ),
        Positioned(
          left: Sizes.size20,
          child: Container(
            height: Sizes.size40,
            width: Sizes.size28,
            padding: EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size12),
            ),
          ),
        ),
        Container(
          height: Sizes.size40,
          padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
          decoration: BoxDecoration(
            color: !inverted || isDarkMode(context) ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(Sizes.size12),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: !inverted || isDarkMode(context) ? Colors.black : Colors.white,
              size: Sizes.size20,
            ),
          ),
        ),
      ],
    );
  }
}
