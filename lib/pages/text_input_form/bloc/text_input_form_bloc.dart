import 'package:flutter_bloc/flutter_bloc.dart';

part 'text_input_form_event.dart';
part 'text_input_form_state.dart';

class TextInputBloc extends Bloc<TextInputEvent, TextInputState> {
  TextInputBloc({
    bool isPassword = false,
    String? initialValue,
    String? Function(String?)? validator,
  }) : super(TextInputState(
          value: initialValue ?? '',
          isPassword: isPassword,
          obscureText: isPassword,
          error: null,
        )) {
    on<TextInputChanged>(_onChanged);
    on<TextInputToggleObscureText>(_onToggleObscureText);
    on<TextInputValidate>(_onValidate);

    _validator = validator;
  }

  String? Function(String?)? _validator;

  void _onChanged(TextInputChanged event, Emitter<TextInputState> emit) {
    emit(state.copyWith(
      value: event.value,
      error: _validator?.call(event.value),
    ));
  }

  void _onToggleObscureText(
      TextInputToggleObscureText event, Emitter<TextInputState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void _onValidate(TextInputValidate event, Emitter<TextInputState> emit) {
    if (_validator != null) {
      emit(state.copyWith(error: _validator!(state.value)));
    }
  }
}
