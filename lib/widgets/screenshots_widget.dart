import 'package:appo_web/models/screenshot_model.dart';
import 'package:flutter/material.dart';

class ScreenshotsWidget extends StatefulWidget {
  @override
  _ScreenshotsWidgetState createState() => _ScreenshotsWidgetState();
}

class _ScreenshotsWidgetState extends State<ScreenshotsWidget>
    with SingleTickerProviderStateMixin {
  List<ScreenshotModel> listScreenshots = [
    ScreenshotModel(
        image: "assets/images/screenshot1.png",
        title: "Registro y login con un solo Click"),
    ScreenshotModel(
        image: "assets/images/screenshot2.png",
        title: "Registro y login con un solo Click"),
    ScreenshotModel(
        image: "assets/images/screenshot3.png",
        title:
            "Encuentre el servicio o el profesional adecuado para usted, y cerca de usted."),
    ScreenshotModel(
        image: "assets/images/screenshot4.png",
        title:
            "Encuentre el servicio o el profesional adecuado para usted, y cerca de usted."),
    ScreenshotModel(
        image: "assets/images/screenshot5.png",
        title: "agenda tus citas o turnos en tus lugares favoritos"),
    ScreenshotModel(
        image: "assets/images/screenshot6.png",
        title: "agenda tus citas o turnos en tus lugares favoritos"),
    ScreenshotModel(
        image: "assets/images/screenshot7.png",
        title: "Date cuenta que hay cerca y agenda tu cita"),
    ScreenshotModel(
        image: "assets/images/screenshot8.png",
        title: "Date cuenta que hay cerca y agenda tu cita"),
    ScreenshotModel(
        image: "assets/images/screenshot9.png",
        title: "Configura todo cuanto quieras"),
    ScreenshotModel(
        image: "assets/images/screenshot10.png",
        title: "Agendar tus citas nunca antes fue tal fácil"),
    ScreenshotModel(
        image: "assets/images/screenshot11.png",
        title: "Appo espera por ti, ten información de tu cita en tiempo real"),
  ];
  Animation<double> sizeAnimation;
  Animation<double> opacityAnimation;
  AnimationController animationController;

  final PageController _pageController = PageController(
    viewportFraction: 0.3,
  );
  int currentPageValue = 0;
  bool isSwitched = true;
  Color colorTextTitle = Colors.black;
  Color colorTextSubTitle = Colors.black87;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    sizeAnimation = Tween<double>(begin: 50, end: 150).animate(
        animationController)
      // opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();

    _pageController.addListener(() {
      int next = _pageController.page.round();
      if (currentPageValue != next)
        setState(() {
          currentPageValue = next;
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        // width: size.width * .9,
        // padding: EdgeInsets.symmetric(horizontal: 100),
        child: PageView.builder(
            itemCount: listScreenshots.length,
            controller: _pageController,
            itemBuilder: (context, int i) {
              bool active = i == currentPageValue;

              return buildScreen(context, listScreenshots[i], active);
            }));
  }

  Widget buildScreen(
      BuildContext context, ScreenshotModel screenshot, bool active) {
    Size size = MediaQuery.of(context).size;

    final double blur = active ? 15 : 0;
    final double offset = active ? 0.0 : 0;
    final double top = active ? 25 : 260;

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          // color: Colors.blue,
          duration: Duration(milliseconds: 400),
          height: active ? size.height : size.height * .5,
          curve: Curves.easeOutQuint,
          // padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(top: top, right: 5.0, bottom: 5.0, left: 0.0),
          alignment: Alignment.center,
          child: Image.asset(
            screenshot.image,
            // height: 800,
            // alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }
}
