import 'package:flutter/material.dart';

class HomePageBackground extends StatelessWidget {
  final Widget child;

  const HomePageBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
color: Color.fromRGBO(64, 224, 208, 0.4),

      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top1.png",
                width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/top2.png",
                width: size.width
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/bottom1.png",
                width: size.width
            ),
          ),

          child
        ],
      ),
    );
  }
}
