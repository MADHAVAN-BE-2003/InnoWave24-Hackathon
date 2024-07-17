import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  // ignore: unused_field
  StreamSubscription<BluetoothAdapterState>? _subscription;
  // FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  Future<void> checkBluetoothSupport() async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
      // Handle the scenario where Bluetooth is not supported
    }
  }

  Future<void> startBluetoothMonitoring() async {
    _subscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      print(state);
      if (state == BluetoothAdapterState.on) {
        // Bluetooth is turned on, proceed with scanning, connecting, etc.
        scanDevices();
      } else {
        // Bluetooth is turned off or in an unknown state, handle appropriately.
      }
    });
  }

  Future scanDevices() async {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
    FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}















































// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
// import 'package:speech_craft/components/bluetooth_controller.dart';

// class BluetoothPage extends StatelessWidget {
//   const BluetoothPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: GetBuilder<BluetoothController>(
//           init: BluetoothController(),
//           builder: (controller) {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: 100,
//                     width: double.infinity,
//                     color: Colors.blue,
//                     child: Center(
//                       child: Text(
//                         "Bluetooth Devices",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () => controller.scanDevices(),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.blue,
//                         minimumSize: Size(350, 55),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                         ),
//                       ),
//                       child: Text(
//                         "Scan",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   StreamBuilder<List<ScanResult>>(
//                     stream: controller.scanResults,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             final data = snapshot.data![index];
//                             return Card(
//                               elevation: 2,
//                               child: ListTile(
//                                 title: Text(data.device.name),
//                                 subtitle: Text(data.device.id.id),
//                                 trailing: Text(data.rssi.toString()),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Center(
//                           child: Text("No devices found"),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
