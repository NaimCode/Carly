import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/bluetooth_provider.dart';
import '../providers/common.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
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
                Get.toNamed("/profile");
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.6,
              crossAxisCount: 3,
              children: ref
                  .watch(navigationProvider)
                  .map((e) => Card(
                        elevation: 7,
                        child: InkWell(
                          onTap: () {
                            ref.read(currentNavProvider.notifier).change(e);
                            Get.toNamed('/features');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(e.icon, size: 40, color: Colors.blue.shade300
                                  // color: Theme.of(context).primaryColor,

                                  ),
                              const SizedBox(height: 10),
                              Text(e.title),
                            ],
                          ),
                        ),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
