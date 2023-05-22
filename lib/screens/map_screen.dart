import 'package:app/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414);

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(posProvider);
    final markers = ref.watch(markersProvider);
    final controller = ref.watch(mapControllerProvider);
    final distance = ref.watch(distanceProvider);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: location == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    markers: markers,
                    //  mapType: MapType.terrain,
                    initialCameraPosition: CameraPosition(
                      target: location,
                      tilt: 49.440717697143555,
                      bearing: 122.8334901395799,
                      zoom: 17.4746,
                    ),
                    onTap: (argument) async {
                      bool result = await Get.defaultDialog(
                        title: "Destination",
                        middleText: "Confirmer la destination !",
                        onConfirm: () => Get.back(result: true),
                        onCancel: () {},
                      );
                      if (result) {
                        ref
                            .read(destinataireProvider.notifier)
                            .update(argument);
                      }
                    },
                    onMapCreated: (GoogleMapController c) {
                      controller.complete(c);
                    },
                  ),
                  Visibility(
                      visible: distance == null ? false : true,
                      child: Chip(label: Text("${distance!.floor() / 100}Km")))
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
