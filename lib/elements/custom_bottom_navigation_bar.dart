import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/pages/home_page/bloc/home_bloc.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int nowPage =
        context.select((BottonNavigationBloc bloc) => bloc.state.nowPage);

    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 5),
      height: 80,
      padding: EdgeInsets.only(left: 10, right: 10, top: 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "$pathForImage${AppImage.buttonNavigationPanel}",
          ),
          fit: BoxFit.cover,
          scale: 1,
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
                  Image.asset(
                      "$pathForImage${AppImage.buttonNavigationRequest}",
                      color:
                          nowPage == 0 ? AppColors.textGreen : AppColors.black),
                  Text(
                    "Мои запросы",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: nowPage == 0
                            ? AppColors.textGreen
                            : AppColors.black),
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
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      color:
                          nowPage == 1 ? AppColors.textGreen : AppColors.black),
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
                Image.asset("$pathForImage${AppImage.buttonNavigationProfile}",
                    color:
                        nowPage == 2 ? AppColors.textGreen : AppColors.black),
                Text(
                  "Профиль",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      color:
                          nowPage == 2 ? AppColors.textGreen : AppColors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
