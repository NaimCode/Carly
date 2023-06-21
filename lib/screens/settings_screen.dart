import 'package:app/providers/common.dart';
import 'package:app/screens/settings/autonomie_screen.dart';
import 'package:app/screens/settings/fenetre_screen.dart';
import 'package:app/screens/settings/pneu_screen.dart';
import 'package:app/screens/settings/portes_screen.dart';
import 'package:app/screens/siege_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _bodies = [
  const PneusScreen(),

  //autonomie
  const AutonomieScreen(),
  //climatisation
  const SiegeScreen(),
  //portes
  const PortesScreen(),
  const FenetreScreen()
];

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menus = ref.watch(settingsNavigationProvider);
    final current = ref.watch(currentSettingsNavProvider);
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: menus.map((e) {
                final index = menus.indexOf(e);
                return ListTile(
                  dense: true,
                  selected: index ==
                      menus.indexWhere(
                          (element) => element.route == current.route),
                  selectedTileColor: Colors.white.withOpacity(.2),
                  leading: Icon(
                    e.icon,
                    size: 20,
                  ),
                  title: Text(e.title, style: const TextStyle(fontSize: 12)),
                  onTap: () {
                    ref.read(currentSettingsNavProvider.notifier).change(e);
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                );
              }).toList()),
        ),
        Expanded(
            child: Card(
                color: Colors.white.withOpacity(.2),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        //animation up to down
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0, 1), end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                        child: _bodies[menus.indexWhere(
                            (element) => element.route == current.route)]))))
      ],
    );
  }
}
