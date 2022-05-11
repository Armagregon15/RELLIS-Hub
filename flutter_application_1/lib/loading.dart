import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//default loading page with animation
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitChasingDots(
          color: Color(0xFF500000),
          size: 50.0,
        ),
      ),
    );
  }
}
