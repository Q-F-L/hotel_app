import 'package:flutter/material.dart';

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
    );
  }
}
