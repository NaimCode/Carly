import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/auth_provider.dart';

final _isLogin = true.obs;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        child: SizedBox(
          width: 440,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Obx(() => AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: _isLogin.value ? const Login() : const Inscription())),
            ),
          ),
        ),
      )),
    );
  }
}

class Login extends HookConsumerWidget {
  const Login({
    super.key,
  });

  void _login(WidgetRef ref, String email, String pwd,
      ValueNotifier<bool> isLoading) async {
    if (email.isEmpty || pwd.isEmpty) {
      Get.snackbar("Erreur", "Veuillez remplir tous les champs",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white);
      return;
    }
    if (!email.isEmail) {
      Get.snackbar("Erreur", "Veuillez entrer un email valide",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade300,
          colorText: Colors.white);
      return;
    }
    try {
      isLoading.value = true;
      await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
            email: email,
            password: pwd,
          );
      Get.snackbar(
        "Succès",
        "Vous êtes connecté",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade300,
        colorText: Colors.white,
      );
      Get.offAllNamed("/");
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      switch (e.code) {
        case "invalid-email":
          Get.snackbar("Erreur", "Email invalide",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade300,
              colorText: Colors.white);
          break;
        case "user-not-found":
          Get.snackbar("Erreur", "Utilisateur non trouvé",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade300,
              colorText: Colors.white);
          break;
        case "wrong-password":
          Get.snackbar("Erreur", "Mot de passe incorrect",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade300,
              colorText: Colors.white);
          break;
        default:
          Get.snackbar("Erreur", e.message!,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade300,
              colorText: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final isLoading = useState(false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Login",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 20),
        TextField(
          controller: email,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Mot de passe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      _login(
                        ref,
                        email.text,
                        password.text,
                        isLoading,
                      );
                    },
                    child: const Text("Se connecter"))),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Vous n'avez pas un compte?"),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () => _isLogin.value = false,
                child: const Text("S'inscrire",
                    style: TextStyle(color: Colors.white)))
          ],
        )
      ],
    );
  }
}

class Inscription extends HookConsumerWidget {
  const Inscription({
    super.key,
  });

  void _inscription(WidgetRef ref, String email, String password,
      String confirm, ValueNotifier<bool> isLoading) async {
    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      Get.snackbar("Erreur", "Veuillez remplir tous les champs",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    if (password != confirm) {
      Get.snackbar("Erreur", "Les mots de passe ne sont pas identiques",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    if (!email.isEmail) {
      Get.snackbar("Erreur", "Veuillez entrer un email valide",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    try {
      isLoading.value = true;
      await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      Get.snackbar(
        "Succès",
        "Inscription réussie",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed("/");
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      switch (e.code) {
        case "email-already-in-use":
          Get.snackbar("Erreur", "Email déjà utilisé",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          break;
        case "invalid-email":
          Get.snackbar("Erreur", "Email invalide",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          break;
        case "weak-password":
          Get.snackbar("Erreur", "Mot de passe trop faible",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          break;
        default:
          Get.snackbar("Erreur", e.message!,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isLoading = useState(false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Insription",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 15),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 15),
        TextField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Mot de passe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 15),
        TextField(
          obscureText: true,
          controller: confirmPasswordController,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Confirmation de mot de passe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 15),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      _inscription(
                          ref,
                          emailController.text,
                          passwordController.text,
                          confirmPasswordController.text,
                          isLoading);
                    },
                    child: const Text("S'inscrire"))),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Vous avez deja un compte?"),
            const SizedBox(width: 10),
            TextButton(
                onPressed: () => _isLogin.value = true,
                child: const Text("Se connecter",
                    style: TextStyle(color: Colors.white)))
          ],
        )
      ],
    );
  }
}
