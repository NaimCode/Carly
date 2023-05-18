import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
        actions: [
          IconButton(
              tooltip: "Profil",
              icon: const Icon(Icons.person),
              onPressed: () {
                Get.toNamed("/profile");
              })
        ],
      ),
    );
  }
}
