import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                    const Positioned(
                        top: 30,
                        left: 30,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("assets/logo.png"),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () => Get.toNamed("/bluetooth"),
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
