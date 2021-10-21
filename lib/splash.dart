import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t2p/registration_page.dart';

// import 'package:tastes2plate/firebase_api.dart';
// import 'package:tastes2plate/login_page.dart';

class Splashscreen extends StatefulWidget {
  @override
  SplashscreenState createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(milliseconds: 100),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RegistrationPage()
                ),
            (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: MediaQuery.of(context).orientation == Orientation.landscape
                  ? BoxFit.fitWidth
                  : BoxFit.fitHeight,
              image: AssetImage('assets/flash-screen.jpg')),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: 300),
              SizedBox(
                height: 10,
              ),
              Text(
                'Aroma & Flavours',
                style:
                    GoogleFonts.oleoScript(color: Colors.white, fontSize: 40),
              ),
              Text(
                'of INDIA',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
