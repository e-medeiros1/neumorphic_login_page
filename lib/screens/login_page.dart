import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:validatorless/validatorless.dart';

import 'package:teste/widgets/neumorphism_effect.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({
    Key? key,
    required this.showRegisterPage,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLightMode = false;
  bool isPressed = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FirebaseAuth currentUser = FirebaseAuth.instance;
  Future signIn() async {
    await currentUser.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const backgroundColor = Color(0xFFE7ECEF);
    const darkBackgroundColor = Color(0xFF2E3239);
    final ternaryColor = isLightMode ? backgroundColor : darkBackgroundColor;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isLightMode == true ? darkBackgroundColor : backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: NeumorphicButton(
                    onPressed: () {
                      setState(() {
                        isLightMode = !isLightMode;
                      });
                    },
                    style: NeumorphicStyle(
                      color:
                          isLightMode ? darkBackgroundColor : backgroundColor,
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
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  'Bem vindo de volta!',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    fontSize: 40,
                    letterSpacing: 2,
                    color: ternaryColor,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          MyNeumorphismEffect(
                            inset: true,
                            isLightMode: isLightMode,
                            width: size.width * .8,
                            height: 70,
                            borderRadius: BorderRadius.circular(20),
                            widget: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 15, left: 15),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: ternaryColor),
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
                            height: 70,
                            borderRadius: BorderRadius.circular(20),
                            widget: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 15, left: 15),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: ternaryColor,
                                  ),
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
                      InkWell(
                        onTap: () {
                          signIn();
                        },
                        child: MyNeumorphismEffect(
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
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  color: ternaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Não possui conta?',
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 17,
                              color: ternaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          InkWell(
                            onTap: widget.showRegisterPage,
                            child: Text(
                              'Cadastre-se',
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ternaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
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
