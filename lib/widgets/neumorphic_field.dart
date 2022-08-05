import 'package:flutter/material.dart';
import 'package:teste/widgets/neumorphism_effect.dart';

// ignore: must_be_immutable
class NeumorphicField extends StatefulWidget {
  bool isLightMode = false;
  bool? obscureText;
  TextEditingController controller = TextEditingController();
  Color? color;
  String hintText;
  // ignore: prefer_typing_uninitialized_variables
  var validator;
  NeumorphicField({
    Key? key,
    required this.isLightMode,
    required this.color,
    required this.hintText,
    required this.controller,
    this.validator,
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
              validator: (validator) {},
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: true,
              autocorrect: true,
              textInputAction: TextInputAction.next,
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
