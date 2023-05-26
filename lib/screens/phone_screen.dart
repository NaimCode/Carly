import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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

class PhoneScreen extends HookConsumerWidget {
  const PhoneScreen({Key? key}) : super(key: key);

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
  List<Contact> contacts = [];

  Future<List<Contact>> getContact() async {
    bool permissionStatus =
        await FlutterContacts.requestPermission(readonly: true);
    if (permissionStatus) {
      // Get all contacts (lightly fetched)
      // List<Contact> contacts = await FlutterContacts.getContacts();

      // Get all contacts (fully fetched)
      return FlutterContacts.getContacts(withProperties: true, withPhoto: true);

      // Get contact with specific ID (fully fetched)
      // Contact contact = await FlutterContacts.getContact(contacts.first.id);
    }
    return [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
        future: getContact(),
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
          if (snapshot.hasData) {
            print(snapshot.data);
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Contacts'),
              ),
              body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // title: Text(contacts.),
                    title: Text(snapshot.data![index].displayName),
                    subtitle: Text(snapshot.data![index].phones.first.number),
                    leading: CircleAvatar(
                      child: Text(snapshot.data![index].displayName[0]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.call),
                      onPressed: () {
                        makePhoneCall(
                            snapshot.data![index].phones.first.number);
                      },
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        });
  }
}
