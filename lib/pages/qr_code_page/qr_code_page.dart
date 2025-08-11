import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../elements/gradient_button.dart';
import '../../themes/themes.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void initState() {
    controller.start();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset('assets/images/left_arrow.png'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Text(
          "Сканировать QR",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  Future.delayed(Duration(milliseconds: 500)).then(
                    (value) {
                      final List<Barcode> barcodes = capture.barcodes;
                      for (final barcode in barcodes) {
                        debugPrint('QR Found! ${barcode.rawValue}');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Container(
                                width: 100,
                                height: 100,
                                color: Colors.red,
                                child: Text("Complited!!!"),
                              );
                            },
                          ),
                        ).then((value) => controller.start());
                      }
                      controller.stop();
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Forrest Terrace Hotel, Владикавказ,\nВерхний Фиагдон",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "№ 301",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 24,
            ),
            GradientButton(
              margin: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {},
              canClick: true,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Text(
                "Готово",
                style: whiteTextButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
