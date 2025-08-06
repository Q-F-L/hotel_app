import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/bottom_navigation/bloc/botton_navigation_bloc.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 80,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/button_navigation.png",
          ),
          fit: BoxFit.cover,
          scale: 0.96,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              style: IconButton.styleFrom(
                fixedSize: Size(92, 65),
              ),
              onPressed: () {
                context
                    .read<BottonNavigationBloc>()
                    .add(BNMoveToEvent(selectedPage: 0));
              },
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/grey_bell.png"),
                  Text(
                    "Мои запросы",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12),
                  )
                ],
              )),
          IconButton(
            style: IconButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              fixedSize: Size(92, 65),
            ),
            onPressed: () {
              context
                  .read<BottonNavigationBloc>()
                  .add(BNMoveToEvent(selectedPage: 1));
            },
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Сервисы",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 12),
                )
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              fixedSize: Size(92, 65),
            ),
            onPressed: () {
              context
                  .read<BottonNavigationBloc>()
                  .add(BNMoveToEvent(selectedPage: 2));
            },
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/user.png"),
                Text(
                  "Профиль",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
