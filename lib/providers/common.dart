import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/navigation_item.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final navigationProvider = Provider<List<NavigationItem>>((ref) {
  return [
    NavigationItem(title: "Radio", route: "radio", icon: Icons.radio),
    NavigationItem(title: "Musique", route: "musique", icon: Icons.music_note),
    NavigationItem(
        title: "Climatisation", route: "climatisation", icon: Icons.thermostat),
    NavigationItem(title: "Phone", route: "phone", icon: Icons.phone),
    NavigationItem(title: "Carte", route: "map", icon: Icons.map_outlined),
    NavigationItem(
        title: "Apropos du vehicule", route: "settings", icon: Icons.settings),
  ];
});

class CurrentNav extends StateNotifier<NavigationItem> {
  CurrentNav(NavigationItem nav) : super(nav);

  void change(NavigationItem item) {
    state = item;
  }
}

final currentNavProvider = StateNotifierProvider<CurrentNav, NavigationItem>(
    (ref) => CurrentNav(ref.watch(navigationProvider).first));

final settingsNavigationProvider = Provider<List<NavigationItem>>((ref) {
  return [
    NavigationItem(title: "Pneus", route: "pneus", icon: Icons.tire_repair),
    NavigationItem(
        title: "Autonomie", route: "autonomie", icon: Icons.battery_2_bar),
    NavigationItem(title: "Siège", route: "siege", icon: Icons.chair_sharp),
    NavigationItem(title: "Portes", route: "portes", icon: Icons.lock),
    NavigationItem(
        title: "Fenetre", route: "fenetre", icon: Icons.window_outlined),
  ];
});

final currentSettingsNavProvider =
    StateNotifierProvider<CurrentNav, NavigationItem>(
        (ref) => CurrentNav(ref.watch(settingsNavigationProvider).first));

void sendNotification(String title, String body) async {
  Get.snackbar(title, body,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      isDismissible: true,
      shouldIconPulse: true,
      duration: const Duration(seconds: 20));
}
