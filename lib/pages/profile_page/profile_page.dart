import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import '../../elements/custom_bottom_navigation_bar.dart';
import '../../elements/gradient_floating_action_button.dart';
import '../../elements/user_favorites_element.dart';
import '../auth_page/bloc/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 170,
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 45,
                  ),
                  Text(
                    "Diana Beppieva",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<AuthBloc>().add(AuthLogout());
                      });
                    },
                    icon: Icon(
                      Icons.output_rounded,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Text(
                "Почта: david@yandex.ru",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: AppColors.grey,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Выселиться",
                  style: headline2_regular,
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
        ),
        IconButton(
            onPressed: () {},
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete_outlined,
                  color: AppColors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Удалить аккаунт",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 20),
                ),
              ],
            )),
      ],
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
