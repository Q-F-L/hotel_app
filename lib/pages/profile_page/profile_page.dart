import 'package:flutter/material.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import '../../elements/custom_bottom_navigation_bar.dart';
import '../../elements/gradient_floating_action_button.dart';
import '../../elements/user_favorites_element.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GradientFloatingActionButton(
        onPressed: () => Navigator.popAndPushNamed(context, "/services"),
        firstColor: AppColors.backgroundWhite,
        secondColor: AppColors.backgroundWhite,
        textColor: AppColors.realBlack,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomSheet: CustomBottomNabigationBar(
        nowRoute: "/profile",
      ),
      appBar: CustomAppbar(
        title: "Мои запросы",
        preferredSize: Size(MediaQuery.of(context).size.width, 100),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 92,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              border: Border.all(color: AppColors.grey1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Diana Beppieva",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 20),
                ),
                Text(
                  "заполните профиль",
                  style: TextStyle(
                    shadows: [
                      Shadow(color: AppColors.realBlack, offset: Offset(0, -5))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromARGB(126, 0, 0, 0),
                    decorationThickness: 1,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "ВАШИ ПРЕДПОЧТЕНИЯ",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                UserFavoritesElement(
                  unorderedList: [
                    'Матрас — средней жесткости',
                    'Подушки — перо '
                  ],
                  name: "СОН",
                  icon: Image.asset('assets\images\sleep_bad.png'),
                ),
                SizedBox(
                  height: 24,
                ),
                UserFavoritesElement(
                  unorderedList: ['С видом на горы', 'Для некурящих'],
                  name: "Номер",
                  icon: Image.asset('assets\images\room.png'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "— ",
          style: labelSmallManrope,
        ),
        Expanded(
          child: Text(
            text,
            style: labelSmallManrope,
          ),
        ),
      ],
    );
  }
}
