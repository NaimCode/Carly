import 'package:app/providers/auth_provider.dart';
import 'package:app/screens/bluetoothPage.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/music_item_screen.dart';
import 'package:app/screens/profile_screen.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/widgets/main_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/bluetooth', page: () => const DiscoveryPage()),
        GetPage(
            name: "/login",
            page: () => const LoginScreen(),
            middlewares: [IsLogged(ref)]),
        GetPage(
            name: "/",
            page: () => const HomeScreen(),
            middlewares: [IsLogged(ref)]),
        GetPage(
            name: "/profile",
            page: () => const ProfileScreen(),
            middlewares: [IsLogged(ref)]),
        GetPage(
            name: "/features",
            page: () => const MainLayout(),
            middlewares: [IsLogged(ref)]),
        GetPage(
            name: "/music",
            page: () => MusicItemScreen(path: Get.arguments),
            middlewares: [IsLogged(ref)]),
      ],
    );
  }
}

class IsLogged extends GetMiddleware {
  final WidgetRef ref;
  IsLogged(this.ref);
  @override
  RouteSettings? redirect(String? route) {
    final user = ref.watch(firebaseAuthProvider).currentUser;
    if (route == "/login") {
      if (user != null) {
        return const RouteSettings(name: "/");
      }
      return null;
    }
    if (user == null) {
      return const RouteSettings(name: "/login");
    }
    return null;
  }
}
