import 'package:flutter/material.dart';

import '../themes/themes.dart';
import 'icon_gradient.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.listString,
    this.icon,
    this.text,
    this.width,
    this.active = true,
    this.onSelected,
  });

  final List<String?> listString;
  final Widget? icon;
  final String? text;
  final double? width;
  final bool active;
  final ValueChanged<String?>? onSelected; // ✅ так правильнее чем Function

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 18.0,
      type: MaterialType.button,
      color: AppColors.textWhite,
      shadowColor: const Color.fromARGB(42, 23, 133, 137),
      child: DropdownMenu<String?>(
        textStyle: Theme.of(context).textTheme.labelSmall,
        width: widget.width,
        enabled: widget.active,
        requestFocusOnTap: false,
        leadingIcon: widget.icon,
        trailingIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color.fromARGB(255, 72, 218, 128),
          size: 26,
        ),
        selectedTrailingIcon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color.fromARGB(255, 72, 218, 128),
        ),
        hintText: widget.text,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: inputText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: AppColors.inputWhite),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: AppColors.inputWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: AppColors.inputWhite, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 24),
        ),
        menuStyle: MenuStyle(
          side: const WidgetStatePropertyAll(BorderSide.none),
          backgroundColor: WidgetStateProperty.all(AppColors.textWhite),
          elevation: WidgetStateProperty.all(8),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        onSelected: (value) {
          setState(() => selectedValue = value);
          if (widget.onSelected != null) {
            widget.onSelected!(value);
          }
        },
        dropdownMenuEntries: widget.listString.map((menu) {
          return DropdownMenuEntry<String?>(
            value: menu,
            label: menu ?? '',
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            ),
            labelWidget: Container(
              width: (widget.width ?? 200) - 20,
              height: 44,
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.divider),
                ),
              ),
              child: Row(
                children: [
                  IconGradient(
                    icon: widget.icon ?? const SizedBox(),
                    colors: const [
                      Color.fromARGB(255, 88, 241, 147),
                      Color.fromARGB(255, 72, 218, 128),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      menu ?? "Не указано",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.black,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
