import 'package:flutter/material.dart';
import 'package:get/get.dart';

final _formKey = GlobalKey<FormState>();
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

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.email),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Mot de passe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {},
            child: const Text("Se connecter")),
        const SizedBox(height: 20),
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

class Inscription extends StatelessWidget {
  const Inscription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Insription",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.email),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Mot de passe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Confirmation de mot de passe",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {},
            child: const Text("S'inscrire")),
        const SizedBox(height: 20),
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
