import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../elements/shower.dart';
import 'bloc/shower_new_page_bloc.dart';

class Showers extends StatefulWidget {
  const Showers({super.key});

  @override
  State<Showers> createState() => _ShowersState();
}

class _ShowersState extends State<Showers> {
  late PageController _pageController;
  late ShowerNewPageBloc showerNewPageBloc;
  static const List<Map> listShowers = [
    {
      "image": "assets/images/bell.png",
      "description": "Заказывайте услуги отеля из любого места онлайн",
      "textButton": "Понятно",
    },
    {
      "image": "assets/images/payment_card.png",
      "description": "Оплачивайте прямо в приложении",
      "textButton": "Хорошо",
    },
    {
      "image": "assets/images/key.png",
      "description": "Оплачивайте прямо в приложении",
      "textButton": "Поехаели!",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    showerNewPageBloc = ShowerNewPageBloc(_pageController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: showerNewPageBloc,
      child: BlocBuilder<ShowerNewPageBloc, ShowerNewPageState>(
        bloc: showerNewPageBloc,
        builder: (context, state) {
          return PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: List<Widget>.generate(
              3,
              (i) {
                return Shower(
                  image: listShowers[i]['image'],
                  description: listShowers[i]['description'],
                  textButton: listShowers[i]['textButton'],
                  onPressLast: 2 == i
                      ? () {
                          Navigator.pushNamed(context, "/auth");
                        }
                      : null,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
