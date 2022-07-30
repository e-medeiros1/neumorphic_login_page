import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

// ignore: must_be_immutable
class MyNeumorphismEffect extends StatelessWidget {
  bool isLightMode = false;
  double width;
  double height;
  Widget? widget;
  BorderRadius borderRadius;
  bool inset;

  MyNeumorphismEffect({
    Key? key,
    required this.isLightMode,
    required this.width,
    required this.height,
    required this.borderRadius,
    this.widget,
    required this.inset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const darkBackgroundColor = Color(0xFF2E3239);
    const darkUpShadow = Color(0xFF35393F);
    const darkdownShadow = Color(0xFF23262A);

    const backgroundColor = Color(0xFFE7ECEF);
    const upShadow = Colors.white;
    const downShadow = Color(0xFFA7A9AF);

    const Offset distance = Offset(2, 2);
    const double blur = 4;

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: blur,
            offset: -distance,
            color: isLightMode == false ? upShadow : darkUpShadow,
            spreadRadius: 1,
            inset: inset,
          ),
          BoxShadow(
            blurRadius: blur,
            offset: distance,
            color: isLightMode == false ? downShadow : darkdownShadow,
            spreadRadius: 1,
            inset: inset,
          ),
        ],
        color: isLightMode == false ? backgroundColor : darkBackgroundColor,
      ),
      height: height,
      width: width,
      child: widget,
    );
  }
}
