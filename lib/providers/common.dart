import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/navigation_item.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final navigationProvider = Provider<List<NavigationItem>>((ref) {
  return [
    NavigationItem(title: "Radio", route: "radio", icon: Icons.radio),
    NavigationItem(title: "Musique", route: "musique", icon: Icons.music_note),
    NavigationItem(title: "Clim", route: "clim", icon: Icons.air),
    NavigationItem(title: "Phone", route: "phone", icon: Icons.phone),
    NavigationItem(title: "Carte", route: "map", icon: Icons.map_outlined),
    NavigationItem(title: "Parametre", route: "settings", icon: Icons.settings),
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
