import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  late final FlutterBlue flutterBlue;
  late Stream<List<ScanResult>> scanResultsStream;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    flutterBlue = FlutterBlue.instance;
    scanResultsStream = flutterBlue.scanResults;
  }

  Future<void> startScan() async {
    setState(() {
      isScanning = true;
    });
    await flutterBlue.startScan();
  }

  Future<void> stopScan() async {
    setState(() {
      isScanning = false;
    });
    await flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "Bluetooth Devices",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: isScanning ? stopScan : startScan,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isScanning ? Colors.red : Colors.blue,
                    minimumSize: Size(350, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  child: Text(
                    isScanning ? "Stop Scan" : "Start Scan",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<List<ScanResult>>(
                stream: scanResultsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final devices = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        final data = devices[index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(data.device.name.isEmpty
                                ? 'Unknown Device'
                                : data.device.name),
                            subtitle: Text(data.device.id.toString()),
                            trailing: Text(data.rssi.toString()),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: Text('No devices found'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
