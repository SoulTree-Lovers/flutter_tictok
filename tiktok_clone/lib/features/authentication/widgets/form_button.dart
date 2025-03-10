import 'package:flutter/material.dart';
import 'package:tictok_clone/utils/utils.dart';

import '../../../constants/sizes.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final VoidCallback onTap;
  final String text;

  const FormButton({
    super.key,
    required this.disabled,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: disabled
                ? isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade300
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Sizes.size6),
          ),
          duration: Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size12),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              style: TextStyle(
                color: disabled ? Colors.grey.shade400 : Colors.white,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w700,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
