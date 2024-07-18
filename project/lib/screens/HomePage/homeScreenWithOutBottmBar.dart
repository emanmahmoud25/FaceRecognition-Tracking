import 'package:flutter/material.dart';
import 'package:project/screens/HomePage/data_card_bottom.dart';

import '../../Models/Card_HomePage.dart';
import 'data_cardTop.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "Main Page",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            IconButton(
              //! to SignOut
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "welcomeScreen", (route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child:

              // ),
              // ! List of First Card in HomePage
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      ...Alldata.map((data) => Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: DataCardOne(data: data),
                          )).toList(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Streaming",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              //! List of Second Card in HomePage
              ...recentData.map(
                (data) => Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: SecondryCardData(
                    data: data,
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
