import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:teste/widgets/neumorphism_effect.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool isLightMode = false;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const backgroundColor = Color(0xFFE7ECEF);
    const darkBackgroundColor = Color(0xFF2E3239);

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isLightMode == true ? darkBackgroundColor : backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  onPressed: () {
                    setState(() {
                      isLightMode = !isLightMode;
                    });
                  },
                  style: NeumorphicStyle(
                    color: isLightMode ? darkBackgroundColor : backgroundColor,
                    shape: NeumorphicShape.flat,
                    depth: isLightMode ? -2 : 2,
                    boxShape: const NeumorphicBoxShape.circle(),
                  ),
                  padding: const EdgeInsets.all(13.0),
                  child: isLightMode == true
                      ? const Icon(
                          Icons.nightlight_outlined,
                          color: backgroundColor,
                        )
                      : const Icon(
                          Icons.wb_sunny_outlined,
                          color: darkBackgroundColor,
                        ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // NeumorphicTextForm(
                      //   hintText: 'Email',
                      //   isLightMode: isLightMode,
                      //   backgroundColor: backgroundColor,
                      //   darkBackgroundColor: darkBackgroundColor,
                      //   isPressed: isPressed,
                      // ),
                      Stack(
                        children: [
                          MyNeumorphismEffect(
                            inset: true,
                            isLightMode: isLightMode,
                            width: size.width * .8,
                            height: 60,
                            borderRadius: BorderRadius.circular(20),
                            widget: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 15, left: 15),
                              child: TextFormField(
                                onTap: () {},
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: isLightMode
                                          ? backgroundColor
                                          : darkBackgroundColor),
                                  hintText: 'Email',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Stack(
                        children: [
                          MyNeumorphismEffect(
                            inset: true,
                            isLightMode: isLightMode,
                            width: size.width * .8,
                            height: 60,
                            borderRadius: BorderRadius.circular(20),
                            widget: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 15, left: 15),
                              child: TextFormField(
                                obscureText: true,
                                onTap: () {},
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: isLightMode
                                          ? backgroundColor
                                          : darkBackgroundColor),
                                  hintText: 'Senha',
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //Custom neumorphic Login button
                      MyNeumorphismEffect(
                        inset: false,
                        isLightMode: isLightMode,
                        width: size.width * .25,
                        height: 50,
                        borderRadius: BorderRadius.circular(20),
                        widget: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                            'Fazer login',
                            style: TextStyle(
                              letterSpacing: 1.1,
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: isLightMode
                                  ? backgroundColor
                                  : darkBackgroundColor,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
