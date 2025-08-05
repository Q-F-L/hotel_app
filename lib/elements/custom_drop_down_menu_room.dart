import 'package:flutter/material.dart';
import 'package:m_softer_test_project/data/rooms.dart';

import '../themes/themes.dart';
import 'icon_gradient.dart';

class CustomDropDownMenuRoom extends StatefulWidget {
  CustomDropDownMenuRoom({
    super.key,
    required this.listString,
    this.icon,
    this.text,
    this.width,
    this.active = true,
    this.onSelected,
  });

  final List<Rooms?> listString;
  final Widget? icon;
  final String? text;
  final double? width;
  Function(Rooms?)? onSelected;
  bool active;
  @override
  State<CustomDropDownMenuRoom> createState() => _CustomDropDownMenuRoomState();
}

class _CustomDropDownMenuRoomState extends State<CustomDropDownMenuRoom> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 18.0,
      type: MaterialType.button,
      color: AppColors.textWhite,
      shadowColor: Color.fromARGB(42, 23, 133, 137),
      child: DropdownMenu<Rooms?>(
        textStyle: Theme.of(context).textTheme.labelSmall,
        width: widget.width,
        enabled: widget.active,
        requestFocusOnTap: false,
        leadingIcon: widget.icon,
        trailingIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color.fromARGB(255, 72, 218, 128),
          size: 26,
        ),
        selectedTrailingIcon: Icon(
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
          side: WidgetStatePropertyAll(BorderSide.none),
          backgroundColor: WidgetStateProperty.all(AppColors.textWhite),
          elevation: WidgetStateProperty.all(8),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        onSelected: widget.onSelected,
        dropdownMenuEntries: widget.listString.asMap().entries.map((entry) {
          int index = entry.key;
          Rooms? menu = entry.value;

          return DropdownMenuEntry<Rooms?>(
            value: menu,
            label: menu?.name ?? '',
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
            ),
            leadingIcon: SizedBox(),
            trailingIcon: SizedBox(),
            labelWidget: Container(
              height: 44,
              width: widget.width! - 20,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconGradient(
                        icon: widget.icon ?? SizedBox(),
                        colors: [
                          Color.fromARGB(255, 88, 241, 147),
                          Color.fromARGB(255, 72, 218, 128),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          menu?.name ?? "Не указано",
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.black,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  if (index != widget.listString.length - 1)
                    const Divider(
                      color: Color(0xFFEEEEEE),
                      thickness: 2,
                      height: 10,
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
