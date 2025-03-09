import 'package:flutter/material.dart';

class FullWidthTapButton extends StatelessWidget {
  final Function onTap;
  final bool isActive;
  final String text;
  final Color? activeColor;

  const FullWidthTapButton({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.text,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: isActive
                  ? (activeColor ?? Theme.of(context).primaryColor)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
