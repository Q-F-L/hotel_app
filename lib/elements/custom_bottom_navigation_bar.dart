import 'package:flutter/material.dart';

class CustomBottomNabigationBar extends StatelessWidget {
  const CustomBottomNabigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 80,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/button_navigation.png",
          ),
          fit: BoxFit.cover,
          scale: 0.96,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              style: IconButton.styleFrom(
                fixedSize: Size(92, 65),
              ),
              onPressed: () {},
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/grey_bell.png"),
                  Text(
                    "Мои запросы",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12),
                  )
                ],
              )),
          IconButton(
            style: IconButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              fixedSize: Size(92, 65),
            ),
            onPressed: () {},
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Сервисы",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 12),
                )
              ],
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              fixedSize: Size(92, 65),
            ),
            onPressed: () {},
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/user.png"),
                Text(
                  "Профиль",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
      // child: Column(
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
      //         SizedBox(),
      //         IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
      //       ],
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text("data"),
      //         Text("data"),
      //         Text("data"),
      //       ],
      //     )
      //   ],
      // ),
    );
    // return BottomAppBar(
    //   elevation: 10,
    //   height: 90,
    //   shape: CircularNotchedRectangle(),
    //   notchMargin: 10.0,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: <Widget>[
    //       IconButton(
    //         icon: Column(
    //           children: [
    //             Image.asset("assets/images/request_bell.png"),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Text(
    //               "data",
    //               style: Theme.of(context).textTheme.labelSmall,
    //             )
    //           ],
    //         ),
    //         onPressed: () {},
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 20),
    //         child: Text(
    //           "Переделать что бы было красиво",
    //           style: Theme.of(context).textTheme.labelSmall,
    //         ),
    //       ),
    //       IconButton(
    //         icon: Column(
    //           children: [
    //             Image.asset("assets/images/user_profil.png"),
    //             Text(
    //               "data",
    //               style: Theme.of(context).textTheme.labelSmall,
    //             )
    //           ],
    //         ),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // );
  }
}
