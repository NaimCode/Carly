import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/common.dart';

final _bodies = [
  const Placeholder(),
  const Placeholder(),
  const Placeholder(),
  const Placeholder(),
  const Placeholder(),
  const Placeholder(),
];

class MainLayout extends HookConsumerWidget {
  const MainLayout({super.key, required this.menu});
  final String menu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(navigationProvider);
    final current = menus.firstWhere(
        (element) => element.title.toLowerCase() == menu.toLowerCase());
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
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          currentIndex:
              menus.indexWhere((element) => element.route == current.route),
          onTap: (index) {
            Get.toNamed('/features/${menus[index].route.toLowerCase()}');
          },
          items: ref
              .read(navigationProvider)
              .map((e) => BottomNavigationBarItem(
                    icon: Icon(e.icon),
                    label: e.title,
                  ))
              .toList()),
    );
  }
}
