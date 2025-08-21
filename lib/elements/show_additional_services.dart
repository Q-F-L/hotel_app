import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m_softer_test_project/data/services/models/services.dart';
import 'package:m_softer_test_project/elements/custom_drop_down_menu.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/text_input_form.dart';
import 'package:m_softer_test_project/pages/services_page/bloc/services_bloc.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class ShowAdditionalServices extends StatefulWidget {
  const ShowAdditionalServices({super.key, required this.options});
  final List<Options> options;

  @override
  State<ShowAdditionalServices> createState() => _ShowAdditionalServicesState();
}

class _ShowAdditionalServicesState extends State<ShowAdditionalServices> {
  // для хранения состояния счётчиков
  final Map<String, int> counters = {};

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: AppColors.white,
      title: Text(
        'Дополнительные услуги',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      children: [
        ...widget.options.map((opt) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildOption(opt),
            )),
        GradientButton(
          canClick: true,
          onPressed: () {
            context
                .read<ServicesBloc>()
                .add(CreateOrder(servicesId: 0, options: widget.options));
          },
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Text("Готово", style: whiteTextButton),
        ),
      ],
    );
  }

  Widget _buildOption(Options option) {
    switch (option.type) {
      case 1:
        return _textOption(option);
      case 2:
        return _counterOption(option);
      case 3:
        return _dropdownOption(option);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _textOption(Options option) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(option.name ?? "", style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 10),
        TextInputForm(
          hintText: option.values ?? "Введите значение",
        ),
      ],
    );
  }

  Widget _counterOption(Options option) {
    counters.putIfAbsent(
        option.name ?? "", () => int.tryParse(option.values ?? "0") ?? 0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(option.name ?? "", style: Theme.of(context).textTheme.labelSmall),
        SizedBox(
          width: 105,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (counters[option.name]! > 0) {
                      counters[option.name ?? ""] = counters[option.name]! - 1;
                    }
                  });
                },
                icon:
                    SvgPicture.asset("$pathForImage${AppImage.outline_minus}"),
              ),
              Text("${counters[option.name]}"),
              IconButton(
                onPressed: () {
                  setState(() {
                    counters[option.name ?? ""] = counters[option.name]! + 1;
                  });
                },
                icon: SvgPicture.asset("$pathForImage${AppImage.outline_plus}"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dropdownOption(Options option) {
    final items = (option.values ?? "")
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(option.name ?? "", style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 10),
        CustomDropDownMenu(
          listString: items,
          active: true,
          text: "Выбрать",
          width: MediaQuery.of(context).size.width * 0.70,
        ),
      ],
    );
  }
}
