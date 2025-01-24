import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../local_storage.dart';

class LocalStorageImpl extends LocalStorage  {
  final GetStorage _storage;

  LocalStorageImpl(this._storage);

  @override
  bool? getOnboardingStatus() {
    // TODO: implement getOnboardingStatus
    throw UnimplementedError();
  }

  @override
  void saveOnboardingStatus(bool hasSeenOnboarding) {
    // TODO: implement saveOnboardingStatus
  }

  // @override
  // bool? getOnboardingStatus() {
  //   return _storage.read<bool?>(AppConstants.onBoardKey);
  // }
  //
  // @override
  // void saveOnboardingStatus(bool hasSeenOnboarding) {
  //   _storage.write(AppConstants.onBoardKey, true);
  // }
}
