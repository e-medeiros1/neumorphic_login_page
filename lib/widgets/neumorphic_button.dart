import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class MyNeumorphicButton extends StatelessWidget {
  bool isLightMode = false;
  Color backgroundColor;
  Color darkBackgroundColor;
  bool isPressed = true;

  VoidCallback? onPressed;

  MyNeumorphicButton({
    Key? key,
    required this.isLightMode,
    required this.backgroundColor,
    required this.darkBackgroundColor,
    required this.isPressed,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NeumorphicButton(
        style: NeumorphicStyle(
          border: NeumorphicBorder(
              // isEnabled: true,
              color:
                  isLightMode == true ? backgroundColor : darkBackgroundColor),
          color: isLightMode ? darkBackgroundColor : backgroundColor,
          shape: NeumorphicShape.flat,
          depth: isLightMode ? -2 : 2,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        ),
        padding: const EdgeInsets.all(13.0),
        child: Text(
          'Fazer login',
          style: TextStyle(
              color: isLightMode ? backgroundColor : darkBackgroundColor),
        ));
  }
}
