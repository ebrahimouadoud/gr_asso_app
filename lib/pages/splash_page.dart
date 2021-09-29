import 'dart:async';

import 'package:flutter/material.dart';
import 'package:green_repack_assos/pages/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    goToNext();
  }

  goToNext() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/icons/logo.jpg",
            width: size.width * .5,
          ),
        ),
      ),
    );
  }
}
