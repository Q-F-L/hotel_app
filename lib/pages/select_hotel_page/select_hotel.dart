import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_softer_test_project/elements/gradient_button.dart';
import 'package:m_softer_test_project/elements/icon_gradient.dart';
import 'package:m_softer_test_project/themes/themes.dart';

import '../../elements/custom_drop_down_menu.dart';
import '../../elements/menu_select_date.dart';
import 'bloc/select_hotel_bloc.dart';

class SelectHome extends StatefulWidget {
  const SelectHome({super.key});

  @override
  State<SelectHome> createState() => _SelectHomeState();
}

class _SelectHomeState extends State<SelectHome> {
  late bool _leadingState;
  late bool _buttonState;
  final List<String?> _listHotel = [
    "dsa",
    "dsadsa da",
    "daa dsad d",
    "   dds  dd   "
  ];

  @override
  void initState() {
    // TODO: implement initState
    _leadingState = true;
    _buttonState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _leadingState
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset('assets/images/left_arrow.png'),
              )
            : null,
        centerTitle: true,
        backgroundColor: const Color(0xFFF6FBFB),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Text(
          "Заезд",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocProvider(
        create: (context) => SelectHotelBloc(),
        child: BlocConsumer<SelectHotelBloc, SelectHotelState>(
          listener: (context, state) {
            if (state.status == SelectHotelStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Ошибка!"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<SelectHotelBloc>();

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              children: [
                CustomDropDownMenu(
                  onSelected: (e) => bloc.add(SelectedHomelEvent(e)),
                  listString: _listHotel,
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
                CustomDropDownMenu(
                  onSelected: (e) => bloc.add(SelectedNumberEvent(e)),
                  listString: _listHotel,
                  icon: Image.asset("assets/images/prefix_key.png"),
                  text: "Номер",
                  active: state.nameHotel != null,
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/services');
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
            );
          },
        ),
      ),
    );
  }
}
