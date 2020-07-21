import 'package:appo_web/pages/home_page.dart';
import 'package:appo_web/services/appbar_nav_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppbarNavService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APPO - Agenda tus citas',
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.kosugiMaruTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Color(0xFFf67262),
          accentColor: Color(0xFFf67262),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "home",
        routes: {"/": (context) => HomePage(), "home": (context) => HomePage()},
      ),
    );
  }
}
