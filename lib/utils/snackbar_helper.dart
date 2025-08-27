import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../themes/themes.dart';

showToast(BuildContext context, String message) {
  FToast fToast = FToast();
  ;
  // Убираем все тосты — и активные, и в очереди
  fToast.removeCustomToast();
  fToast.removeQueuedCustomToasts();

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    decoration: BoxDecoration(
      boxShadow: const [shadow],
      borderRadius: BorderRadius.circular(6),
      color: AppColors.white,
    ),
    child: Text(
      message,
      style: labelSmall,
      textAlign: TextAlign.center,
    ),
  );

  fToast.init(context);

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}
