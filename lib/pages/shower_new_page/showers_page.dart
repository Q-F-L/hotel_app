import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/auth_page/auth_page.dart';
import 'package:m_softer_test_project/pages/launch_bloc/launch_bloc.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import '../../elements/shower.dart';
import 'bloc/shower_new_page_bloc.dart';

class Showers extends StatefulWidget {
  const Showers({super.key});

  @override
  State<Showers> createState() => _ShowersState();
}

class _ShowersState extends State<Showers> {
  late PageController _pageController;
  late ShowerNewPageBloc bloc;
  List<Map> listShowers = [
    {
      "image": "$pathForImage${AppImage.shower1}",
      "description": "Заказывайте услуги отеля из любого места онлайн",
      "textButton": "Понятно",
    },
    {
      "image": "$pathForImage${AppImage.shower2}",
      "description": "Оплачивайте прямо в приложении",
      "textButton": "Хорошо",
    },
    {
      "image": "$pathForImage${AppImage.shower3}",
      "description": "Оплачивайте прямо в приложении",
      "textButton": "Поехаели!",
    },
  ];

  @override
  void initState() {
    _pageController = PageController();
    bloc = ShowerNewPageBloc(_pageController);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<ShowerNewPageBloc, ShowerNewPageState>(
        listener: (context, state) {
          if (state.seen == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
              (Route<dynamic> route) => false,
            );
          }
        },
        bloc: bloc,
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
                  onPress: () {
                    if (i == 2) {
                      context.read<LaunchBloc>().add(CompleteShowersEvent());
                    } else {
                      bloc.add(NewPage());
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
