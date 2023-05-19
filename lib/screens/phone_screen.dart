import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneScreen extends HookConsumerWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = useState("");
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            child: Placeholder(),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  number.value,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Expanded(
                    child:
                        //number
                        GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            children: List.generate(
                                9,
                                (index) => InkWell(
                                      onTap: () async {
                                        await launch("tel://214324234");
                                        number.value = number.value +
                                            (index + 1).toString();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          (index + 1).toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        )),
                                      ),
                                    ))))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
