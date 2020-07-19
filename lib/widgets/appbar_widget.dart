import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          builLogo(context),
          Row(
            children: [
              Text(
                "Inicio",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              SizedBox(
                width: 30,
              ),
              Text("Descargar",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white)),
              SizedBox(
                width: 30,
              ),
              Text("Contacto",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white))
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
