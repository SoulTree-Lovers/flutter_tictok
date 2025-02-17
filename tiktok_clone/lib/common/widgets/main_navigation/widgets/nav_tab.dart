import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/utils/utils.dart';

import '../../../../constants/gaps.dart';

class NavTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int currentIndex;

  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: currentIndex == 0 || isDarkMode(context)
              ? Colors.black
              : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.5,
            duration: Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: currentIndex == 0 || isDarkMode(context)
                      ? Colors.white
                      : Colors.grey.shade600,
                ),
                Gaps.v10,
                Text(
                  text,
                  style: TextStyle(
                    color: currentIndex == 0 || isDarkMode(context)
                        ? Colors.white
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
