import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_req/core/themes/standard_color.dart';
import '../../../core/localizations/app_localizations.dart';
import '../../../data/onboard_data.dart';
import '../../../widget/buttons/large_btn.dart';
import '../../../widget/buttons/small_btn.dart';
import '../../../widget/navigation/navigation.dart';
import '../../authentification/login_screen.dart';

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
              padding: const EdgeInsets.all(8.0),
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
            const SizedBox(height: 20),
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
        Lottie.asset(image, height: 250, fit: BoxFit.cover),
        const SizedBox(height: 20),
        Center(
          child: Text(
            AppLocalizations.of(context)!.translate(text)!,
            style: TextStyle(
              fontSize: 20,
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
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : StandardColor.greyColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}