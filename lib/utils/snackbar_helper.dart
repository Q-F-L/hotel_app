import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../themes/themes.dart';

showToast(BuildContext context, String message, {bool? focus = false}) {
  FToast fToast = FToast();

  // Убираем все тосты активные, очереди
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
    gravity: focus ?? false ? ToastGravity.CENTER : ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}
