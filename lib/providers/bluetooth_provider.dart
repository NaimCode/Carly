import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BluetoothNotifier extends StateNotifier<BluetoothConnection?> {
  BluetoothNotifier() : super(null);
  BluetoothDevice? device;
  void connect(BluetoothDevice device) async {
    try {
      state?.close();
      this.device = device;
      if (device.isConnected) {}
      if (!device.isConnected) {
        state = await BluetoothConnection.toAddress(device.address);
      }
      Get.toNamed("/");
    } catch (e) {
      print(e);
      Get.rawSnackbar(
          title: "Erreur de connexion",
          message: "Veuillez réessayer ou changer de périphérique",
          duration: const Duration(seconds: 3));
    }
  }

  void disconnect() {
    state?.close();
    state = null;
  }
}

final bluetoothProvider =
    StateNotifierProvider<BluetoothNotifier, BluetoothConnection?>(
        (ref) => BluetoothNotifier());
