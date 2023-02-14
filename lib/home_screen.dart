import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_app/register_screen.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Register()))));
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.android_sharp,
              size: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'WELLCOME',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Lottie.asset('assets/wellcome.json',
                width: double.infinity, height: 150)
          ],
        ),
      )),
    );
  }
}
