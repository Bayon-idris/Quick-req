import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../utils/sizers_helpers.dart';

class SmallBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const SmallBtn({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36,
        width: 66,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center, // Center the text in the button
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 7),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(width: 7),
          ],
        ),
      ),
    );
  }
}
