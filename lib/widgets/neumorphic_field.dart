import 'package:flutter/material.dart';

import 'package:teste/widgets/neumorphism_effect.dart';

class NeumorphicField extends StatefulWidget {
  bool isLightMode = false;
  bool? obscureText;
  TextEditingController controller = TextEditingController();
  Color? color;
  String hintText;
  NeumorphicField({
    Key? key,
    required this.isLightMode,
    required this.color,
    required this.hintText,
    required this.controller,
     this.obscureText,
  }) : super(key: key);

  @override
  State<NeumorphicField> createState() => _NeumorphicFieldState();
}

class _NeumorphicFieldState extends State<NeumorphicField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        MyNeumorphismEffect(
          inset: true,
          isLightMode: widget.isLightMode,
          width: size.width * .8,
          height: 70,
          borderRadius: BorderRadius.circular(20),
          widget: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15, left: 15),
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obscureText!,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: widget.color,
                ),
                hintText: widget.hintText,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
