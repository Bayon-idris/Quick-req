import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import '../../utils/sizers_helpers.dart';

class CircleStepBtn extends StatelessWidget {
  final bool isActive;

  const CircleStepBtn({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.inversePrimary,
          width: 1.2.dp,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: getWidth(4, context),
          backgroundColor:
          isActive ? Theme.of(context).primaryColor : Colors.transparent,
        ),
      ),
    );
  }
}
