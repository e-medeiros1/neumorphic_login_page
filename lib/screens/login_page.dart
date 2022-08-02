import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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

  Map<String, String> _authData = {'email': '', 'password': ''};

  //Form key para obter as informações do formulário
  final _formKey = GlobalKey<FormState>();

  bool _isLogin() => _authMode == AuthMode.LoginMode;
  bool _isSignup() => _authMode == AuthMode.SignupMode;

//TextButton para mudar pra tela de cadastro
  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.SignupMode;
      } else {
        _authMode = AuthMode.LoginMode;
      }
    });
  }

  FirebaseAuth currentUser = FirebaseAuth.instance;
  Future signIn() async {
    await currentUser.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  Future signUp() async {
    if (passwordConfimed()) {
      await currentUser.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      addUsername(_usernameController.text.trim());
    }
  }

  Future addUsername(String username) async {
    await FirebaseFirestore.instance.collection('users').add({
      'username': username,
    });
  }

  bool passwordConfimed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //Método para enviar as informações pro BD
  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {});

    _formKey.currentState?.save();

    _showErrorDialog(String msg) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Ocorreu um erro',
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            msg,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: const Text('OK'))
          ],
        ),
      );
    }

    try {
      if (_isLogin()) {
        //Login
        signIn();
      } else {
        //Signup
        signUp();
      }
    } on Exception catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }

    setState(() {});
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
                        hintText: 'Nome de usuário'),
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
