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
    return Scaffold(
      appBar: CustomAppbar(
        title: "Мои запросы",
        preferredSize: Size(MediaQuery.of(context).size.width, 124),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
    );
  }
}
