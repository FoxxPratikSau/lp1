import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigProvider with ChangeNotifier {
  bool showDiscountedPrice = false;
  bool isInitialized = false;
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  RemoteConfigProvider() {
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero, // For testing purposes
    ));
    await fetchRemoteConfig();
    isInitialized = true;
    notifyListeners();
  }

  Future<void> fetchRemoteConfig() async {
    try {
      await remoteConfig.fetchAndActivate();
      showDiscountedPrice = remoteConfig.getBool('showDiscountedPrice');
      print('Fetched showDiscountedPrice: $showDiscountedPrice');
      notifyListeners(); // Notify listeners of the change}
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }
}
