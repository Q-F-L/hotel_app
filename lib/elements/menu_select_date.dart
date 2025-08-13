import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';
import '../themes/themes.dart';

class MenuSelectDate extends StatefulWidget {
  MenuSelectDate({super.key, required this.onChange});

  Function(String?) onChange;

  @override
  State<MenuSelectDate> createState() => _MenuSelectDateState();
}

class _MenuSelectDateState extends State<MenuSelectDate> {
  TextEditingController? dropdownController;
  String? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            DateTime buffer = DateTime.now();

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
                      onChange: (datetime) {
                        buffer = datetime;
                      },
                    ),
                  ),
                  Divider(
                    color: AppColors.grey1,
                    height: 2,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onChange(DateFormat('dd MM yyyy').format(buffer));
                      setState(() {
                        selected = DateFormat('dd MM yyyy').format(buffer);
                      });
                      Navigator.pop(context);
                    },
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
        elevation: 18,
        shadowColor: AppColors.shadow,
        color: Colors.transparent,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/images/prefix_date.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    selected ?? "Дата заезда",
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color.fromARGB(255, 72, 218, 128),
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
