import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_req/widget/buttons/large_btn.dart';
import '../../core/localizations/app_localizations.dart';
import '../../quick_rep_main.dart';
import '../../widget/navigation/navigation.dart';

class LoginScreen extends ConsumerStatefulWidget{
  const LoginScreen({super.key});

  @override
  LoginScreenState createState()=>LoginScreenState();
}


class LoginScreenState extends ConsumerState<LoginScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/svgs/lock.svg',
                height: 25,
                width: 25,
              ),
              Text(
                AppLocalizations.of(context)!.translate('login')!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  color:
                  Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                AppLocalizations.of(context)!.translate('please_login')!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color:
                  Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 40),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: SvgPicture.asset(
                        'assets/svgs/course.svg',
                        height: 36,
                        width: 36,
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('matricule')!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: InputDecoration(
                            hintText: '22W2472',
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:EdgeInsets.only(bottom:30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 0.6,
                      ),
                    ),
                    SizedBox(width:5),
                    Text(
                      AppLocalizations.of(context)!.translate('or_continue_with')!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(width:5),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 0.6,
                      ),
                    ),
                    SizedBox(width:10),
                  ],
                ),
              ),

              Padding(
                padding:EdgeInsets.only(bottom:30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary, width: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svgs/google.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: (){},
                          ),
                        ),
                        SizedBox(width:20),
                        Container(
                          width: 80,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary, width: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svgs/apple.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: (){},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              LargeBtn(onPressed: (){
                setState(() {
                  navigateToNextPage(context,QuickReq());
                });
              },
                  titleText: AppLocalizations.of(context)!.translate('login_now')!),
            ],
          ),
        ),
      ),
    );
  }
}