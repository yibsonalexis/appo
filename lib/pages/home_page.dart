import 'dart:async';

import 'package:appo_web/pages/contact_page.dart';
import 'package:appo_web/pages/download_page.dart';
import 'package:appo_web/services/appbar_nav_services.dart';
import 'package:appo_web/widgets/appbar_widget.dart';
import 'package:appo_web/widgets/screenshots_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController _pageController = PageController();
  Timer _debounce;

  @override
  void initState() {
    // _pageController.addListener(() {
    //   Provider.of<AppbarNavService>(context, listen: false).currentIndexNav =
    //       _pageController.page.floor();
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppbarNavService _navService = Provider.of<AppbarNavService>(context);

    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(context, _navService),
      body: Stack(
        children: [
          PageView(
            controller: _navService.pageController,
            onPageChanged: (int pageIndex) {
              if (_debounce != null) {
                _debounce.cancel();
              }
              _debounce = Timer(Duration(milliseconds: 400), () {
                _navService.currentIndexNav = pageIndex;
              });
            },
            scrollDirection: Axis.vertical,
            children: [buildHomeBody(context), DownloadPage(), ContactPage()],
          ),
          AppBarWidget()
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar(
      BuildContext context, AppbarNavService _navService) {
    Size size = MediaQuery.of(context).size;

    return size.width < 700
        ? BottomNavigationBar(
            currentIndex: _navService.currentIndexNav,
            onTap: (value) {
              _navService.currentIndexNav = value;
            },
            unselectedItemColor: Colors.white,
            items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text("Inicio")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.file_download), title: Text("Descargar")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info), title: Text("Contacto")),
              ])
        : Container(
            width: 0,
            height: 0,
          );
  }

  Widget buildHomeBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
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
            fit: BoxFit.fill,
            height: 350,
          ),
        ),
        ScreenshotsWidget(),
      ],
    );
  }
}
