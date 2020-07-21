import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sigue nuestros pasos en:",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 30, color: Colors.white70)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width * .2,
              ),
              InkWell(
                onTap: () =>
                    _launchURL("https://www.facebook.com/APPO-102074794908173"),
                child: Image.asset(
                  "assets/images/social/facebook.png",
                  width: size.width * .1,
                ),
              ),
              InkWell(
                onTap: () => _launchURL("https://www.instagram.com/appo_co/"),
                child: Image.asset(
                  "assets/images/social/instagram.png",
                  width: size.width * .1,
                  fit: BoxFit.contain,
                ),
              ),
              Image.asset(
                "assets/images/social/linkedin.png",
                width: size.width * .1,
                fit: BoxFit.contain,
              ),
              Image.asset(
                "assets/images/social/twitter.png",
                width: size.width * .1,
              ),
              Image.asset(
                "assets/images/social/youtube.png",
                width: size.width * .1,
              ),
              SizedBox(
                width: size.width * .2,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "🙂 Con APPO puedes estar tranquilo y aprovechar tiempo valioso",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20, color: Colors.white70)),
              Text("😊 Agenda tus citas de donde quiera que estes",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20, color: Colors.white70)),
              Text(
                  "🥰 Encuentre el servicio o el profesional adecuado para usted, y cerca de usted",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20, color: Colors.white70)),
              Text("😍 APPO te avisa cuando se acerca la hora de ser atendido",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20, color: Colors.white70)),
            ],
          )
        ],
      ),
    );
  }
}
