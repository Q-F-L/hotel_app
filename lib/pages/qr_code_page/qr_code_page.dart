import 'dart:math';

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
  final controller = MobileScannerController(
    useNewCameraSelector: false,
    autoStart: false,
    formats: [BarcodeFormat.qrCode],
  );
  late final QrCodeBloc bloc;

  @override
  void initState() {
    controller.start();

    bloc = QrCodeBloc();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    controller.dispose();
    bloc.close();
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
        title: Text(
          "Сканировать QR",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<QrCodeBloc, QrCodeState>(
          listener: (context, state) {
            if (state is CheckInSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false,
              );
            }

            if (state.status == QrCodeStatus.failure) {
              showToast(context, state.errorMessage ?? "Error null");
            }
            if (state.status == QrCodeStatus.success) {
              showToast(context, "Success");
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: MobileScanner(
                      key: ValueKey(DateTime.now()
                          .millisecondsSinceEpoch), // для разработчика удалить при сборке продакшена.
                      overlayBuilder: (context, constraints) {
                        return state.status != QrCodeStatus.loading
                            ? CustomPaint(
                                painter: QrScannerOverlay(
                                  borderColor: Colors.white,
                                  borderWidth: 3.0,
                                  borderRadius: 20.0,
                                  borderLength: 35.0,
                                  cutOutSize:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                              )
                            : CircularProgressIndicator(strokeWidth: 2);
                      },
                      controller: controller,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;

                        for (final barcode in barcodes) {
                          bloc.add(ScanQrCodeEvent(response: barcode.rawValue));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  columnTextResponse(state),
                  SizedBox(
                    height: 24,
                  ),
                  GradientButton(
                    canClick: state.oraganizationIfno?.success ?? false,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {
                      bloc.add(CheckIn(
                        roomId: state.oraganizationIfno!.room!.id!,
                        date: DateTime.now().toString(),
                      ));
                    },
                    borderRadius: BorderRadius.all(Radius.circular(16)),
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
    return state.oraganizationIfno?.success ?? false
        ? SizedBox(
            height: 50,
            child: Column(
              children: [
                Text(
                  '${state.oraganizationIfno?.room?.organization?.title ?? 'Нет названия организации'}, ${state.oraganizationIfno?.room?.organization?.physicalAddress ?? 'Нет адреса'}, ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 16),
                ),
                Text(
                  "№ ${state.oraganizationIfno?.room?.name ?? 'Нет комнаты'}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 16),
                ),
              ],
            ),
          )
        : SizedBox();
  }
}

class QrScannerOverlay extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  QrScannerOverlay({
    this.borderColor = Colors.white,
    this.borderWidth = 4.0,
    this.borderRadius = 12.0,
    this.borderLength = 30.0,
    required this.cutOutSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeJoin = StrokeJoin.round;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final halfSize = cutOutSize / 2;

    _drawCorner(canvas, paint, centerX - halfSize, centerY - halfSize, 0);
    _drawCorner(canvas, paint, centerX + halfSize, centerY - halfSize, 90);
    _drawCorner(canvas, paint, centerX + halfSize, centerY + halfSize, 180);
    _drawCorner(canvas, paint, centerX - halfSize, centerY + halfSize, 270);
  }

  void _drawCorner(
      Canvas canvas, Paint paint, double x, double y, double rotation) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(rotation * pi / 180);

    final cornerPath = Path()
      ..moveTo(0, borderLength)
      ..lineTo(0, 0)
      ..lineTo(borderLength, 0);

    canvas.drawPath(cornerPath, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
