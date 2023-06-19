import 'package:flutter/material.dart';

class onboard2 extends StatefulWidget {
  const onboard2({super.key});

  @override
  State<onboard2> createState() => _onboard1State();
}

class _onboard1State extends State<onboard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Image.asset('assets/onboarding2.png'),
    );
  }
}