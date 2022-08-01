import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:teste/widgets/neumorphism_effect.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLightMode = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  FirebaseAuth currentUser = FirebaseAuth.instance;
  Future signUp() async {
    if (_passwordConfimed()) {
      await currentUser.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  bool _passwordConfimed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                  'Seja bem vindo!',
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
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: ternaryColor,
                                  ),
                                  hintText: 'Confirma senha',
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
                          signUp();
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
                                'Criar conta',
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
                            'Já possui conta?',
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
                            onTap: widget.showLoginPage,
                            child: Text(
                              'Faça o login',
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
