import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/data/rooms/model.dart';
import 'package:m_softer_test_project/elements/custom_drop_down_menu_hotel.dart';
import 'package:m_softer_test_project/elements/custom_drop_down_menu_room.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/pages/home_page/home.dart';
import 'package:m_softer_test_project/themes/themes.dart';
import 'package:m_softer_test_project/utils/snackbar_helper.dart';

import '../../elements/menu_select_date.dart';
import 'bloc/select_hotel_bloc.dart';

class SelectHomePage extends StatefulWidget {
  const SelectHomePage({super.key});

  @override
  State<SelectHomePage> createState() => _SelectHomePageState();
}

class _SelectHomePageState extends State<SelectHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.popAndPushNamed(context, '/auth'),
          icon: Image.asset('assets/images/left_arrow.png'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Заезд",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocProvider(
        create: (context) => SelectHotelBloc()..add(RequestHotelsEvent()),
        child: BlocConsumer<SelectHotelBloc, SelectHotelState>(
          listener: (context, state) {
            if (state.status == SelectHotelStatus.send) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            } else if (state.status == SelectHotelStatus.failure) {
              showToast(context, "Ошибка: ${state.errorMessage}");
            }

            if (state.status == SelectHotelStatus.complited) {
              Navigator.pushNamed(context, '/home');
            }
          },
          builder: (context, state) {
            final bloc = context.read<SelectHotelBloc>();

            return SafeArea(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                children: [
                  CustomDropDownMenuHotel(
                    onSelected: (e) => bloc.add(SelectedHotelEvent(e)),
                    list: state.listHotel,
                    icon: IconGradient(icon: Icon(Icons.hotel), colors: [
                      Color.fromARGB(255, 88, 241, 147),
                      Color.fromARGB(255, 72, 218, 128),
                    ]),
                    text: "Ваш отель",
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropDownMenuRoom(
                    onSelected: (e) => bloc.add(SelectedRoomEvent(e)),
                    listString: state.listRooms ?? [Rooms(name: "loading....")],
                    icon: Image.asset("assets/images/prefix_key.png"),
                    text: "Номер",
                    active: state.hotel != null,
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MenuSelectDate(
                    onChange: (e) => bloc.add(SelectedDateEvent(e)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                    onPressed: () async {
                      if (bloc.canClick) {
                        bloc.add(SendEvent());
                      }
                    },
                    canClick: bloc.canClick,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Text(
                      "Готово",
                      style: whiteTextButton,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "или",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GradientButton(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    onPressed: () {
                      Navigator.pushNamed(context, '/qr_code_page');
                    },
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/prefix_qr-code.png"),
                        Text(
                          "Cканировать QR",
                          style: whiteTextButton,
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
