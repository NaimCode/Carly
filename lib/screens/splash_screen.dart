import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bg_splash_small.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    filterQuality: FilterQuality.low),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () => Get.toNamed("/login"),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Get Started"),
                            const SizedBox(width: 20),
                            Lottie.asset("assets/arrow.json",
                                width: 30, height: 30)
                          ],
                        ))
                  ],
                ),
              ))),
    );
  }
}
