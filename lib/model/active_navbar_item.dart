import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timbumed/service/color.dart';

class RedDot extends StatelessWidget {
  final bool isSelected;

  const RedDot({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4), // Add some space
        FaIcon(
          isSelected ? FontAwesomeIcons.solidCircle : null,
          color: isSelected ? AppColor.primaryColor : Colors.transparent,
          size: 8,
        ),
      ],
    );
  }
}
