import 'package:flutter/material.dart';
import 'package:m_softer_test_project/elements/custom_drop_down_menu.dart';
import 'package:m_softer_test_project/elements/text_input_form.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class ShowAdditionalServices extends StatefulWidget {
  const ShowAdditionalServices({super.key});

  @override
  State<ShowAdditionalServices> createState() => _ShowAdditionalServicesState();
}

class _ShowAdditionalServicesState extends State<ShowAdditionalServices> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: AppColors.white,
      title: Text(
        'Дополнительные услуги',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      children: <Widget>[
        Text(
          'Тапочки и халат',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(
          height: 15,
        ),
        CustomDropDownMenu(
            listString: ["dsa", 'dsa2 3', 'dsad'],
            active: true,
            text: "Выбрать",
            width: MediaQuery.of(context).size.width * 0.70),
        SizedBox(
          height: 30,
        ),
        Text(
          'Фен',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        SizedBox(
          height: 15,
        ),
        TextInputForm(
          hintText: "Выбрать",
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Зубная щётка',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(
              width: 105,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (counter > 0) {
                          --counter;
                        }
                      });
                    },
                    icon:
                        Image.asset("assets/images/remove_circle_outline.png"),
                  ),
                  Text("${counter}"),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        ++counter;
                      });
                    },
                    icon: Image.asset("assets/images/add_circle_outline.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
