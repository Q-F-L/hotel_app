import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/user/models/user.dart';
import 'package:m_softer_test_project/pages/auth_page/auth_page.dart';
import 'package:m_softer_test_project/pages/profile_page/bloc/profile_bloc.dart';
import 'package:m_softer_test_project/pages/select_hotel_page/select_hotel.dart';
import 'package:m_softer_test_project/themes/themes.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import '../../elements/user_favorites_element.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc bloc;

  @override
  void initState() {
    bloc = ProfileBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(CreateProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is CheckOutState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SelectHomePage()),
              (Route<dynamic> route) => false,
            );
          }

          if (state is LogoutState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
              (Route<dynamic> route) => false,
            );
          }

          if (state is ProfileErrorState) {
            showToast(context, state.message);
          }
        },
        builder: (context, state) {
          return ListView(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grey1),
                  boxShadow: [shadow],
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
                          "${User.firstName} ${User.lastName}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {
                            bloc.add(LogoutEvent());
                          },
                          icon: Icon(
                            Icons.output_rounded,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Почта: ${User.email}",
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
                      onPressed: () {
                        bloc.add(CheckOutEvent());
                      },
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
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              //   margin: EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(16),
              //     color: AppColors.white,
              //     boxShadow: [shadow],
              //   ),
              //   child: Column(
              //     children: [
              //       Text(
              //         "ВАШИ ПРЕДПОЧТЕНИЯ",
              //         style: Theme.of(context)
              //             .textTheme
              //             .headlineLarge
              //             ?.copyWith(fontSize: 20),
              //       ),
              //       SizedBox(
              //         height: 20,
              //       ),
              //       UserFavoritesElement(
              //         unorderedList: [
              //           'Матрас — средней жесткости',
              //           'Подушки — перо '
              //         ],
              //         name: "СОН",
              //         icon: Image.asset('assets\images\sleep_bad.png'),
              //       ),
              //       SizedBox(
              //         height: 24,
              //       ),
              //       UserFavoritesElement(
              //         unorderedList: ['С видом на горы', 'Для некурящих'],
              //         name: "Номер",
              //         icon: Image.asset('assets\images\room.png'),
              //       ),
              //     ],
              //   ),
              // ),
              IconButton(
                  onPressed: () {
                    bloc.add(DeleteUser());
                  },
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
        },
      ),
    );
  }
}
