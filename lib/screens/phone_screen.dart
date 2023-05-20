import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneScreen extends HookConsumerWidget {
  const PhoneScreen({Key? key}) : super(key: key);
  void makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar("Erreur", "Impossible d'appeler ce numéro",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 3,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: number,
                style: const TextStyle(letterSpacing: 5),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(letterSpacing: 0),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: InputBorder.none,
                  hintText: "Enter your phone number",
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: () {
                makePhoneCall(number.text);
              },
              label: const Text("Appel"),
              icon: const Icon(Icons.call),
            ),
          ],
        ),
      ),
      body: const Contacts(),
    );
  }
}

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  FullContact? contacts;

  getContact() async {
    if (!await FlutterContactPicker.hasPermission()) {
      await FlutterContactPicker.requestPermission();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FullContact>(
        future: FlutterContactPicker.pickFullContact(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erreur lors de la récupération des contacts"),
            );
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Contacts'),
            ),
            body: contacts == null
                ? const SizedBox()
                : ListView.builder(
                    itemCount: contacts!.phones.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // title: Text(contacts.),
                        subtitle: Text(contacts!.phones[index].number ?? ""),
                      );
                    },
                  ),
          );
        });
  }
}
