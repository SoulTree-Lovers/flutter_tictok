import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';

class InterestButton extends StatefulWidget {
  final String interest;

  const InterestButton({
    super.key,
    required this.interest,
  });

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size12,
          horizontal: Sizes.size12,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size32),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: Sizes.size5,
              spreadRadius: Sizes.size5,
            ),
          ],
        ),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: _isSelected ? Colors.white : Colors.black54,
          ),
          child: Text(
            widget.interest,
          ),
        ),
      ),
    );
  }
}
