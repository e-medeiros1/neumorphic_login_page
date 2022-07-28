import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextForm extends StatelessWidget {
  bool isLightMode = false;
  Color backgroundColor;
  Color darkBackgroundColor;
  bool isPressed = true;
  String hintText;
  VoidCallback? onPressed;

  NeumorphicTextForm({
    Key? key,
    required this.isLightMode,
    required this.backgroundColor,
    required this.darkBackgroundColor,
    required this.isPressed,
    required this.hintText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Neumorphic(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(12.0),
      style: NeumorphicStyle(
        // border: NeumorphicBorder(
        //     // isEnabled: true,
        //     color: isLightMode == true ? backgroundColor : darkBackgroundColor),
        color: isLightMode ? darkBackgroundColor : backgroundColor,
        shape: NeumorphicShape.concave,
        depth: -3,
        shadowLightColorEmboss: Color(0xFFA7A9AF),
        shadowLightColor: Color(0xFFE7ECEF),
        shadowDarkColorEmboss: Color(0xFF23262A),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
      ),
      child: SizedBox(
        height: 35,
        width: size.width * .8,
        child: TextField(
          onTap: onPressed,
          decoration: InputDecoration(
            hintStyle: TextStyle(
                color: isLightMode ? backgroundColor : darkBackgroundColor),
            hintText: hintText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
