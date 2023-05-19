import 'package:app/screens/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/common.dart';
import '../screens/radio_screen.dart';

final _bodies = [
  const RadioScreen(),
  const PhoneScreen(),
  const Placeholder(),
  const Placeholder(),
  const Placeholder(),
  const Placeholder(),
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