import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class DownloadPage extends StatelessWidget {
  _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.appo.app';
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Encuentranos en Android o iOS",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontSize: 30, color: Colors.white70),
            ),
          ),
          size.width > 765
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: _launchURL,
                      child: Image.asset(
                        "assets/images/googleplay.png",
                        width: 150,
                      ),
                    ),
                    Image.asset(
                      "assets/images/screenshot2.png",
                      height: size.width * .4,
                      width: size.width * .3,
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      "assets/images/screenshot_ios1.png",
                      height: size.width * .4,
                      width: size.width * .3,
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      "assets/images/applestore.png",
                      width: 150,
                    ),
                  ],
                )
              : Column(
                  children: [
                    InkWell(
                      onTap: _launchURL,
                      child: Image.asset(
                        "assets/images/googleplay.png",
                        width: 150,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/images/applestore.png",
                      width: 150,
                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
                "No esperes mas, agenda tus citas y aprovecha tu tiempo",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 20, color: Colors.white70)),
          )
        ],
      ),
    );
  }
}
