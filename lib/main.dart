import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_req/quick_req.dart';
import 'package:quick_req/restart_widget.dart';


Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  runApp(
    ProviderScope(
      child: RestartWidget(child: QuickReq()),
    ),
  );
  FlutterNativeSplash.remove();
}