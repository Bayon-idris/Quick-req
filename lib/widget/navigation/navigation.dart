import 'package:flutter/cupertino.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

void navigateToNextPage(BuildContext context, Widget nextPage) {
  Navigator.of(context).push(
    SwipeablePageRoute(
      builder: (_) => nextPage,
      canOnlySwipeFromEdge: true,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  );
}