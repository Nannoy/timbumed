import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/img/logo.png',)
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //         'Timbu',
        //       style: TextStyle(
        //         fontFamily: 'Nunito',
        //         fontWeight: FontWeight.w900,
        //         fontSize: 25
        //       ),
        //     ),
        //     Text(
        //         'Med',
        //       style: TextStyle(
        //           fontFamily: 'Nunito',
        //           fontWeight: FontWeight.w500,
        //           fontSize: 25,
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
