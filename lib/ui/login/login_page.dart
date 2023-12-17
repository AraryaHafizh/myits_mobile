import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/login/login_logic.dart';
import 'package:myits_portal/ui/login/reset_pass_page.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = true;
  final TextEditingController nrpInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final FocusNode nrpFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchDataFromAPI();
  }

  @override
  void dispose() {
    nrpInput.dispose();
    passwordInput.dispose();
    nrpFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: itsBlueStatic,
      body: Center(
        child: SizedBox(
          width: 510,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  child: Image.asset(
                    'assets/images/its.png',
                    width: 160,
                    height: 160,
                  ),
                ),
                nrpField(),
                passwordField(),
                options(context),
                loginButton(),
                const Spacer(),
                credit(false, context),
                const SizedBox(height: 25)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nrpField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: nrpInput,
        focusNode: nrpFocusNode,
        cursorColor: itsYellowStatic,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(passwordFocusNode);
        },
        style: jakarta.copyWith(fontSize: 14, color: whiteStatic),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        decoration: loginTheme.copyWith(
            labelText: 'NRP',
            labelStyle: jakarta.copyWith(fontSize: 14, color: whiteStatic)),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      onFieldSubmitted: (value) {
        userInputCheck(context, nrpInput.text, passwordInput.text);
      },
      textInputAction: TextInputAction.send,
      cursorColor: itsYellowStatic,
      controller: passwordInput,
      focusNode: passwordFocusNode,
      obscureText: passwordVisible,
      style: jakarta.copyWith(fontSize: 14, color: whiteStatic),
      decoration: loginTheme.copyWith(
          labelText: 'Password',
          labelStyle: jakarta.copyWith(fontSize: 14, color: whiteStatic),
          suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              })),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        userInputCheck(context, nrpInput.text, passwordInput.text);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(itsYellowStatic),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
      ),
      child: Text('Log In',
          style: jakarta.copyWith(fontSize: 14, color: Colors.black)),
    );
  }
}

errorDialog(context) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text('Login Gagal',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20)),
            content: SizedBox(
              width: 220,
              height: 37,
              child: Text('Silahkan cek kembali NRP dan Password anda.',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 14)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: jakarta.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              )
            ],
          )));
}

Widget options(context) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassPage()));
      },
      child: Text('Forged Password?',
          style: jakarta.copyWith(fontSize: 11, color: whiteStatic)),
    ),
  );
}
