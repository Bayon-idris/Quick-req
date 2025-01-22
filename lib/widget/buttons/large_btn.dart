import 'package:flutter/material.dart';
import '../../core/themes/standard_color.dart';

class LargeBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String titleText;

  const LargeBtn({
    super.key,
    required this.onPressed,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            gradient: btnLinearGradient,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titleText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
