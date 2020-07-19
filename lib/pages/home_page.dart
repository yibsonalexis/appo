import 'package:appo_web/widgets/appbar_widget.dart';
import 'package:appo_web/widgets/screenshots_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFDF8F6),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/bg1.png",
              width: size.width * .5,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/rocket.png",
              height: size.height * .5,
            ),
          ),
          Positioned(
            top: 0,
            // bottom: 0,
            child: Image.asset(
              "assets/images/bg2.png",
              width: size.width,
              // height: size.height * .5,
            ),
          ),
          ScreenshotsWidget(),
          AppBarWidget()
        ],
      ),
    );
  }
}
