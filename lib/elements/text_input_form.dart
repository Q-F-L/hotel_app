import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/text_input_form/bloc/text_input_form_bloc.dart';
import '../themes/themes.dart';

class TextInputForm extends StatefulWidget {
  TextInputForm({
    super.key,
    this.prefix,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.onChanged,
    this.hintText,
    this.errorText,
    this.controller,
  });

  final Widget? prefix;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? hintText;
  String? errorText;
  final TextEditingController? controller;

  @override
  State<TextInputForm> createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm> {
  late final TextInputBloc _bloc;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _bloc = TextInputBloc(
      isPassword: widget.isPassword,
      initialValue: widget.initialValue,
      validator: widget.validator,
    );
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _bloc.add(TextInputValidate());
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextInputBloc, TextInputState>(
      bloc: _bloc,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(boxShadow: [shadow]),
          child: TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            obscureText: state.obscureText,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
              prefixIcon: widget.prefix,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        state.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color.fromARGB(255, 27, 194, 122),
                      ),
                      onPressed: () {
                        _bloc.add(TextInputToggleObscureText());
                      },
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.inputWhite,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.inputWhite,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              hintText: widget.hintText,
              hintStyle: inputText,
              errorText: state.error,
            ),
          ),
        );
      },
    );
  }
}
