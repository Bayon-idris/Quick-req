import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_req/quick_rep_main.dart';

import 'constant/app_constant.dart';
import 'core/localizations/app_localizations_delegate.dart';
import 'core/localizations/providers/app_language_provider.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/providers/theme_provider.dart';
import 'features/onboard/screens/onboard.dart';
final navigatorKey = GlobalKey<NavigatorState>();

class QuickReq extends ConsumerStatefulWidget{
  const QuickReq({super.key});


  @override
  ConsumerState<QuickReq> createState() => _QuickReqState();
}

class _QuickReqState extends ConsumerState<QuickReq>{
  @override
  Widget build(BuildContext context){
    final appLanguage = ref.watch(appLanguageProvider);
    final themeNotifier = ref.watch(themeProvider);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeNotifier.themeMode,
        builder: EasyLoading.init(),
        home: Onboard(),
        locale: appLanguage.appLocale,
        navigatorKey: navigatorKey,
        supportedLocales: AppLocalizationsDelegate.supportedLocales,
        localizationsDelegates: AppLocalizationsDelegate.iterableDelegates,
      );
  }

}