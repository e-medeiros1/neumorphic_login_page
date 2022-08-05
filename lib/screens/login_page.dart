// ignore_for_file: constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:teste/screens/home_page.dart';
import 'package:teste/widgets/neumorphism_effect.dart';
import '../widgets/neumorphic_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum AuthMode { LoginMode, SignupMode }

class _LoginPageState extends State<LoginPage> {
  bool isLightMode = false;
  bool isPressed = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  AuthMode _authMode = AuthMode.LoginMode;

  bool _isLogin() => _authMode == AuthMode.LoginMode;
  bool _isSignup() => _authMode == AuthMode.SignupMode;

//Muda enum
  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.SignupMode;
      } else {
        _authMode = AuthMode.LoginMode;
      }
    });
  }

  //Loga
  FirebaseAuth currentUser = FirebaseAuth.instance;

  Future signIn() async {
    await currentUser.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  //Cria conta
  Future signUp() async {
    if (passwordConfimed()) {
      await currentUser.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = Users(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
      );

      createUser(user);
    }
  }

  Future createUser(Users? user) async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('cKbnGh9mkGaIlhCpl9Hn');

    user!.id = docUser.id;

    final json = user.toJson();

    await docUser.set(json);
  }

  //Adiciona nome e email de usuário

  //Confirma se senha é igual a confirma senha
  bool passwordConfimed() {
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
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const backgroundColor = Color(0xFFE7ECEF);
    const darkBackgroundColor = Color(0xFF2E3239);
    final ternaryColor = isLightMode ? backgroundColor : darkBackgroundColor;
    return Scaffold(
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
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                _isLogin() ? 'Bem vindo de volta!' : 'Olá, bem vindo!',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isSignup())
                    NeumorphicField(
                      isLightMode: isLightMode,
                      controller: _usernameController,
                      color: ternaryColor,
                      obscureText: false,
                      hintText: 'Nome de usuário',
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  NeumorphicField(
                      isLightMode: isLightMode,
                      controller: _emailController,
                      obscureText: false,
                      color: ternaryColor,
                      hintText: 'Email'),
                  const SizedBox(
                    height: 15,
                  ),
                  NeumorphicField(
                      isLightMode: isLightMode,
                      controller: _passwordController,
                      color: ternaryColor,
                      obscureText: true,
                      hintText: 'Senha'),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_isSignup())
                    NeumorphicField(
                        isLightMode: isLightMode,
                        controller: _confirmPasswordController,
                        color: ternaryColor,
                        obscureText: true,
                        hintText: 'Confirma senha'),
                  const SizedBox(
                    height: 30,
                  ),

                  //Custom neumorphic Login button
                  InkWell(
                    onTap: () {
                      if (_isLogin()) {
                        signIn();
                      } else if (_isSignup()) {
                        signUp();
                      }
                    },
                    child: MyNeumorphismEffect(
                      inset: false,
                      isLightMode: isLightMode,
                      width: size.width * .26,
                      height: 50,
                      borderRadius: BorderRadius.circular(20),
                      widget: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            _isLogin() ? 'Fazer login' : 'Criar conta',
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 15,
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
                        _isLogin() ? 'Não possui conta?' : 'Já possui conta?',
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
                        onTap: _switchAuthMode,
                        child: Text(
                          _isLogin() ? 'Cadastre-se' : 'Faça o login',
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
            ],
          ),
        ),
      ),
    );
  }
}
