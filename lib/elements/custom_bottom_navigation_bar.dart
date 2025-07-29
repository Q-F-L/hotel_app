import 'package:flutter/material.dart';
import 'package:m_softer_test_project/themes/themes.dart';

class CustomBottomNabigationBar extends StatelessWidget {
  const CustomBottomNabigationBar({super.key, required this.nowRoute});
  final String nowRoute;

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
                if (nowRoute != "/requsts") {
                  Navigator.pushNamed(context, "/requsts");
                }
              },
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/grey_bell.png",
                    color: nowRoute != "/requsts"
                        ? AppColors.black
                        : AppColors.lightGreen,
                  ),
                  Text(
                    "Мои запросы",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 12,
                          color: nowRoute != "/requsts"
                              ? AppColors.black
                              : AppColors.lightGreen,
                        ),
                  )
                ],
              )),
          IconButton(
            style: IconButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              fixedSize: Size(92, 65),
            ),
            onPressed: () {
              if (nowRoute != "/services") {
                Navigator.pushNamed(context, "/services");
              }
            },
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Сервисы",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: nowRoute != "/services"
                            ? AppColors.black
                            : AppColors.lightGreen,
                      ),
                )
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              fixedSize: Size(92, 65),
            ),
            onPressed: () {
              if (nowRoute != "/profile") {
                Navigator.pushNamed(context, "/profile");
              }
            },
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/user.png",
                  color: nowRoute != "/profile"
                      ? AppColors.black
                      : AppColors.lightGreen,
                ),
                Text(
                  "Профиль",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: nowRoute != "/profile"
                            ? AppColors.black
                            : AppColors.lightGreen,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
