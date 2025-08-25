import 'package:flutter/material.dart';
import 'package:m_softer_test_project/elements/custom_appbar.dart';

import '../../elements/card_request.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppbar(
            title: "Сервисы",
            preferredSize: Size(MediaQuery.of(context).size.width, 124),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 132,
            child: ListView(
              clipBehavior: Clip.none,
              children: [
                CardRequest(),
                CardRequest(),
                CardRequest(),
                CardRequest(),
                SizedBox(
                  height: 160,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
