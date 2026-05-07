import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/home_page/home.dart';
import 'package:m_softer_test_project/pages/qr_code_page/bloc/qr_code_bloc.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../elements/gradient_button.dart';
import '../../themes/themes.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  final MobileScannerController controller = MobileScannerController(
    returnImage: true,
    autoStart: true,
    formats: [BarcodeFormat.qrCode],
  );

  late final QrCodeBloc bloc;
  Uint8List? scannedImage;

  @override
  void initState() {
    super.initState();
    bloc = QrCodeBloc();
  }

  @override
  void dispose() {
    controller.dispose();
    bloc.close();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcodes = capture.barcodes;

    setState(() {
      scannedImage = capture.image;
    });

    for (final barcode in barcodes) {
      final value = barcode.rawValue;
      if (value != null) {
        bloc.add(ScanQrCodeEvent(response: value));
      }
    }

    controller.stop();
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
        title: Text(
          "Сканировать QR",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocProvider(
        create: (_) => bloc,
        child: BlocConsumer<QrCodeBloc, QrCodeState>(
          listener: (context, state) {
            if (state is CheckInSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
              );
            }

            if (state.status == QrCodeStatus.failure) {
              showToast(context, state.errorMessage ?? "Error");
            }

            if (state.status == QrCodeStatus.success) {
              showToast(context, "Success");
            }
          },
          builder: (context, state) {
            final success = state.oraganizationIfno?.success ?? false;

            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        if (scannedImage != null)
                          Image.memory(
                            scannedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        else
                          MobileScanner(
                            controller: controller,
                            onDetect: _onDetect,
                          ),

                        // 🔥 OVERLAY (замена overlayBuilder)
                        if (scannedImage == null)
                          IgnorePointer(
                            child: CustomPaint(
                              painter: QrScannerOverlay(
                                cutOutSize:
                                MediaQuery.of(context).size.width * 0.5,
                              ),
                              child: Container(),
                            ),
                          ),

                        if (state.status == QrCodeStatus.loading)
                          const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  columnTextResponse(state),

                  const SizedBox(height: 24),

                  GradientButton(
                    canClick: success,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: success
                        ? () {
                      bloc.add(
                        CheckIn(
                          roomId: state.oraganizationIfno!.room!.id!,
                          date: DateTime.now().toString(),
                        ),
                      );
                    }
                        : null,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(16)),
                    child: Text(
                      "Готово",
                      style: whiteTextButton,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget columnTextResponse(QrCodeState state) {
    final info = state.oraganizationIfno;

    if (info?.success != true) return const SizedBox();

    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Text(
            '${info?.room?.organization?.title ?? 'Нет названия'}, '
                '${info?.room?.organization?.physicalAddress ?? 'Нет адреса'}',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 16),
          ),
          Text(
            "№ ${info?.room?.name ?? 'Нет комнаты'}",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class QrScannerOverlay extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderLength;
  final double cutOutSize;

  QrScannerOverlay({
    this.borderColor = Colors.white,
    this.borderWidth = 4.0,
    this.borderLength = 30.0,
    required this.cutOutSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final half = cutOutSize / 2;

    _drawCorner(canvas, paint, centerX - half, centerY - half, 0);
    _drawCorner(canvas, paint, centerX + half, centerY - half, 90);
    _drawCorner(canvas, paint, centerX + half, centerY + half, 180);
    _drawCorner(canvas, paint, centerX - half, centerY + half, 270);
  }

  void _drawCorner(Canvas canvas, Paint paint, double x, double y, double rot) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rot * pi / 180);

    final path = Path()
      ..moveTo(0, 30)
      ..lineTo(0, 0)
      ..lineTo(30, 0);

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}