import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';
import '../themes/themes.dart';

class MenuSelectDate extends StatefulWidget {
  const MenuSelectDate({super.key});

  @override
  State<MenuSelectDate> createState() => _MenuSelectDateState();
}

class _MenuSelectDateState extends State<MenuSelectDate> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.inputWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 280,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ScrollDateTimePicker(
                      centerWidget: DateTimePickerCenterWidget(
                        builder: (context, constraints, child) {
                          return Container(
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: const Color.fromARGB(145, 224, 224, 224),
                            ),
                            child: child,
                          );
                        },
                      ),
                      style: DateTimePickerStyle(
                        activeStyle: Theme.of(context).textTheme.labelMedium,
                        inactiveStyle: Theme.of(context).textTheme.labelLarge,
                        disabledStyle: Theme.of(context).textTheme.labelLarge ??
                            TextStyle(),
                      ),
                      wheelOption: DateTimePickerWheelOption(
                        perspective: 0.0015,
                        diameterRatio: 1.12,
                        squeeze: 2.1,
                        offAxisFraction: 1.7,
                        clipBehavior: Clip.antiAlias,
                      ),
                      itemExtent: 70,
                      dateOption: DateTimePickerOption(
                        dateFormat: DateFormat('ddMMMyyyy', 'ru_RU'),
                        minDate: DateTime.now(),
                        maxDate: DateTime(2030),
                        initialDate: DateTime.now(),
                      ),
                      onChange: (datetime) {},
                    ),
                  ),
                  Divider(
                    color: AppColors.grey1,
                    height: 2,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Далее",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 18.0,
        type: MaterialType.button,
        color: AppColors.textWhite,
        shadowColor: Color.fromARGB(38, 26, 251, 255),
        child: DropdownMenu(
          enabled: false,
          width: MediaQuery.of(context).size.width * 0.90,
          requestFocusOnTap: false,
          leadingIcon: Image.asset("assets/images/prefix_date.png"),
          trailingIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color.fromARGB(255, 72, 218, 128),
            size: 26,
          ),
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color.fromARGB(255, 72, 218, 128),
          ),
          hintText: "Дата заезда",
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: Theme.of(context).textTheme.labelSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 255, 0, 0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: const Color.fromARGB(0, 255, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
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
          dropdownMenuEntries: [],
        ),
      ),
    );
  }
}
