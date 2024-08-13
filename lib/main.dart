import 'package:flutter/material.dart';
import 'package:mobile_scanner_poc/mobile_scanner/qr_barcode_scanner_module.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Scanner POC"),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (bc) => QrBarcodeScannerScreen()));
            },
            child: Text("Scan Code")),
      ),
    );
  }
}
