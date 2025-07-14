part of 'text_input_form_bloc.dart';

abstract class TextInputEvent {}

class TextInputChanged extends TextInputEvent {
  final String value;

  TextInputChanged(this.value);
}

class TextInputToggleObscureText extends TextInputEvent {}

class TextInputValidate extends TextInputEvent {}
