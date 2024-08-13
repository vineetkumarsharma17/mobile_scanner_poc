part of '../qr_barcode_scanner_module.dart';

class QrBarcodeScannerScreen extends StatefulWidget {
  const QrBarcodeScannerScreen({super.key});

  @override
  State<QrBarcodeScannerScreen> createState() => _QrBarcodeScannerScreenState();
}

class _QrBarcodeScannerScreenState extends State<QrBarcodeScannerScreen> {
  MobileScannerController controller = MobileScannerController();
  bool isQrCodeScan = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MobileScanner(
      onDetect: handleCode,
      controller: controller,
      overlayBuilder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      borderRadius: 0,
                      borderLength: 20,
                      borderWidth: 5,
                      cutOutWidth: MediaQuery.of(context).size.width - 40,
                      cutOutHeight: 200),
                ),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  backButton(context),
                  Spacer(),
                  qrTextWidget(),
                  barcodeButton(),
                ],
              ),
            )),
          ],
        );
      },
    ));
  }

  Widget qrTextWidget() {
    return Text(
        isQrCodeScan
            ? "Hold QR Code on the vehicle inside the frame. It will scan automatically."
            : "Hold VIN bar code inside the frame. It will scan automatically.",
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "AvertaStd",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
        textAlign: TextAlign.center);
  }

  Widget barcodeButton() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isQrCodeScan) {
              setState(() {
                isQrCodeScan = !isQrCodeScan;
              });
            } else {}
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30, bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                color: Color.fromRGBO(39, 110, 138, 1)),
            child: Text(
                isQrCodeScan ? "Scan VIN Bar Code" : "Enter VIN Manually",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "AvertaStd",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.center),
          ),
        ),
        // Rectangle 3
        if (!isQrCodeScan)
          GestureDetector(
            onTap: () {
              setState(() {
                isQrCodeScan = true;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(70)),
                  border: Border.all(color: Colors.white, width: 2)),
              child: // Primary Button Default
                  const Text("Scan QR Code",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "AvertaStd",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.center),
            ),
          ),
      ],
    );
  }

  GestureDetector backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Row(
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          Text(
            "Back",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  handleCode(BarcodeCapture barcodes) async {
    var barcode = barcodes.barcodes.firstOrNull;

    if (mounted) {
      await controller.stop();
      log("barcodes: ${barcode!.rawValue}");
      Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (bc) => ResultScreen(barcode: barcode)))
          .then((val) => controller.start());
    }
  }

  showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Text("data");
      },
    );
  }
}
