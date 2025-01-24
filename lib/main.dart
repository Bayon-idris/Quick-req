import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'constant/app_constant.dart';
import 'core/localizations/app_localizations_delegate.dart';
import 'core/localizations/providers/app_language_provider.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/providers/theme_provider.dart';
import 'features/onboard/screens/onboard.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appLanguage = ref.watch(appLanguageProvider);
    final themeNotifier = ref.watch(themeProvider);
    return FlutterSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeNotifier.themeMode,
            builder: EasyLoading.init(),
            home: const Onboard(),
            locale: appLanguage.appLocale,
            navigatorKey: navigatorKey,
            supportedLocales: AppLocalizationsDelegate.supportedLocales,
            localizationsDelegates: AppLocalizationsDelegate.iterableDelegates,
          );
        }
    );
  }
}