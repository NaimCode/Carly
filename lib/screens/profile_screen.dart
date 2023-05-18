import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/auth_provider.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade300,
              ),
              onPressed: () async {
                await ref.read(firebaseAuthProvider).signOut();
                Get.offAllNamed("/login");
              },
              icon: const Icon(Icons.logout),
              label: const Text("Déconnexion"))
        ],
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
