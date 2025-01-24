import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_req/core/themes/standard_color.dart';
import 'package:quick_req/utils/sizers_helpers.dart';
import '../../../core/localizations/app_localizations.dart';
import '../../../data/onboard_data.dart';
import '../../../widget/buttons/large_btn.dart';
import '../../../widget/buttons/small_btn.dart';
import '../../../widget/navigation/navigation.dart';
import '../../authentification/Screens/login_screen.dart';

class Onboard extends ConsumerStatefulWidget {
  const Onboard({super.key});

  @override
  OnboardState createState() => OnboardState();
}

class OnboardState extends ConsumerState<Onboard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.all(8.dp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _currentPage < 2
                      ?
                  SmallBtn(
                    title: AppLocalizations.of(context)!.translate('skip')!,
                    onPressed:(){
                      _pageController.jumpToPage(2);
                  },
                  ):SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: OnboardData.data.length,
                itemBuilder: (context, index) => OnboardPage(
                  image: OnboardData.data[index]["image"] ?? "",
                  text: OnboardData.data[index]["textKey"] ?? "",
                ),
              ),
            ),
            Padding(
                padding:EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    LargeBtn(onPressed: () {
                      setState(() {
                        navigateToNextPage(context,LoginScreen());
                      });
                    },
                      titleText:AppLocalizations.of(context)!.translate('login')!,),
                  ],
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnboardData.data.length,
                    (index) => IndicatorDot(isActive: index == _currentPage),
              ),
            ),
            SizedBox(height: getHeight(20, context)),
          ],
        ),
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String image;
  final String text;

  const OnboardPage({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(image, height: getHeight(250, context), fit: BoxFit.cover),
        SizedBox(height: getHeight(20, context)),
        Center(
          child: Text(
            AppLocalizations.of(context)!.translate(text)!,
            style: TextStyle(
              fontSize:20.dp,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;

  const IndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.dp),
      height: 10,
      width: isActive ? getHeight(20, context) :getWidth(10, context),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : StandardColor.greyColor,
        borderRadius: BorderRadius.circular(5.dp),
      ),
    );
  }
}