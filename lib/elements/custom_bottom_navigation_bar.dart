import 'package:flutter/material.dart';

class CustomBottomNabigationBar extends StatelessWidget {
  const CustomBottomNabigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      height: 90,
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Column(
              children: [
                Image.asset("assets/images/request_bell.png"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "data",
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Переделать что бы было красиво",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          IconButton(
            icon: Column(
              children: [
                Image.asset("assets/images/user_profil.png"),
                Text(
                  "data",
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
