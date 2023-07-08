import 'package:app/screens/map_screen.dart';
import 'package:app/screens/music_screen.dart';
import 'package:app/screens/phone_screen.dart';
import 'package:app/screens/settings/clim_screen.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/bluetooth_provider.dart';
import '../providers/common.dart';
import '../screens/radio_screen.dart';

final _bodies = [
  const RadioScreen(),
  const MusicScreen(),
  // const Placeholder(),
  const ClimScreen(),
  const PhoneScreen(),
  const MapScreen(),
  const SettingsScreen(),
];

class MainLayout extends HookConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(navigationProvider);
    final current = ref.watch(currentNavProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(current.title),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Get.toNamed("/bluetooth");
              },
              icon: const Icon(Icons.drive_eta),
              label: Text(ref.read(bluetoothProvider.notifier).device?.name ??
                  "Pas de nom")),
          IconButton(
              tooltip: "Profil",
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, "/profile");
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _bodies[
            menus.indexWhere((element) => element.route == current.route)],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: BottomNavigationBar(
            //  fixedColor: Colors.white,
            elevation: 5,
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.white,
            useLegacyColorScheme: true,
            unselectedItemColor: Colors.white.withOpacity(.5),
            selectedItemColor: Colors.white,
            currentIndex:
                menus.indexWhere((element) => element.route == current.route),
            onTap: (index) {
              ref.read(currentNavProvider.notifier).change(menus[index]);
            },
            items: ref
                .read(navigationProvider)
                .map((e) => BottomNavigationBarItem(
                      icon: Icon(e.icon),
                      label: e.title,
                    ))
                .toList()),
      ),
    );
  }
}
