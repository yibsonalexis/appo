import 'package:appo_web/services/appbar_nav_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  // AppbarNavService _navService = AppbarNavService();

  final List<String> itemsBar = ["Inicio ", "Descargar", "Contactanos"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppbarNavService _navService = Provider.of<AppbarNavService>(context);
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          builLogo(context),
          size.width > 700
              ? Row(
                  children: itemsBar.map<Widget>((e) {
                    int index = itemsBar.indexOf(e);
                    bool isActive = index == _navService.currentIndexNav;
                    return InkWell(
                        onTap: () {
                          _navService.currentIndexNav = index;
                          setState(() {});
                        },
                        hoverColor: Colors.transparent,
                        child: buildItemNav(isActive, e, context));
                  }).toList(),
                )
              : Container()
        ],
      ),
    );
  }

  Container buildItemNav(bool isActive, String e, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Stack(
        children: [
          Container(),
          AnimatedContainer(
            curve: Curves.easeInOutQuad,
            duration: Duration(milliseconds: 400),
            width: isActive ? 40 : 0,
            height: isActive ? 40 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF78361), Color(0xFFF54B64)])),
          ),
          Column(
            children: [
              Text(e,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                      )),
              SizedBox(
                height: 4,
              ),
              AnimatedContainer(
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 400),
                width: isActive ? 150 : 0,
                height: isActive ? 3 : 0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          )
        ],
      ),
    );
  }

  Row builLogo(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          // margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: Image.asset(
            "assets/images/logo.png",
            width: 80,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "APPO",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
