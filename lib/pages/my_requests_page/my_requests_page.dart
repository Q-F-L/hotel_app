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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppbar(
          title: "Сервисы",
        ),
        ClipRect(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 137,
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
          ),
        ),
      ],
    );
  }
}
