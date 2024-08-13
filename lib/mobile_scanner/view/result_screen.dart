import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.barcode});
  final Barcode barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  row("Type", barcode.type.name ?? ""),
                  row("Data", barcode.rawValue ?? ""),
                  row("Format", barcode.format.name ?? ""),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Row row(key, value) {
    return Row(
      children: [
        Text(
          key,
          overflow: TextOverflow.fade,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.fade,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildBarcode(Barcode value) {
    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }
}
