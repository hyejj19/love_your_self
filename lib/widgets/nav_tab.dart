import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTab extends StatelessWidget {
  const NavTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          FontAwesomeIcons.house,
          color: Colors.black87,
        ),
      ],
    );
  }
}
