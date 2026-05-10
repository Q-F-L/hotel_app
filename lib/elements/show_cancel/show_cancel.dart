import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/text_input_form.dart';
import 'package:m_softer_test_project/themes/themes.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import 'bloc/cancel_bloc.dart';

class ShowCancel extends StatelessWidget {
  final int orderId;

  const ShowCancel({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CancelOrderBloc(),
      child:
      BlocConsumer<CancelOrderBloc, CancelOrderState>(
        listener: (context, state) {
          if (state is CancelOrderSuccess) {
            Navigator.pop(context);

            showToast(context, state.message ?? "Пустое сообщение",
                focus: WidgetsBinding.instance.window.viewInsets.bottom > 0);
          }

          if (state is CancelOrderError) {
            showToast(context, state.error ?? "Пустое сообщение",
                focus: WidgetsBinding.instance.window.viewInsets.bottom > 0);
          }
        },
        builder: (context, state) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            backgroundColor: AppColors.white,
            title: Text(
              'Отмена заказа',
              textAlign: TextAlign.center,
              style:
              Theme.of(context).textTheme.bodySmall,
            ),
            children: <Widget>[
              TextInputForm(
                hintText:
                "Комментарий/Причина отмены",
                onChanged: (value) {
                  context
                      .read<CancelOrderBloc>()
                      .add(
                    ChangeCancelCommentEvent(
                      value,
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed:
                state is CancelOrderLoading
                    ? null
                    : () {
                  context
                      .read<
                      CancelOrderBloc>()
                      .add(
                    SendCancelOrderEvent(
                      orderId,
                    ),
                  );
                },
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                child:
                state is CancelOrderLoading
                    ? CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text(
                  "Готово",
                  style: whiteTextButton,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}