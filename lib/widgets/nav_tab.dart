import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onTap;

  const NavTab({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: FaIcon(
            icon,
            color: color,
          ),
        ),
      ],
    );
  }
}
