import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/data/data_mhs.dart';
import 'package:myits_portal/pages/login/reset_pass_page.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = true;
  final TextEditingController _nrpInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('islogin', true);
    await prefs.setInt('nrp', int.parse(_nrpInput.text));

    Navigator.pushReplacementNamed(context, '/homepage');
  }

  @override
  void dispose() {
    _nrpInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itsBlueStatic,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/its.png',
              width: 160,
              height: 160,
            ),
            const SizedBox(
              height: 22,
            ),
            nrpField(),
            const SizedBox(
              height: 15,
            ),
            passwordField(),
            options(),
            loginButton(),
            const SizedBox(height: 55),
            credit(false)
          ],
        ),
      ),
    );
  }

  // -------------- NRP field --------------

  Widget nrpField() {
    return TextField(
      controller: _nrpInput,
      style: jakarta.copyWith(fontSize: 14, color: whiteStatic),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      decoration: loginTheme.copyWith(
          labelText: 'NRP', labelStyle: jakarta.copyWith(fontSize: 14, color: whiteStatic)),
    );
  }

  // -------------- password field --------------

  Widget passwordField() {
    return TextFormField(
      controller: _passwordInput,
      obscureText: _passwordVisible,
      style: jakarta.copyWith(fontSize: 14, color: whiteStatic),
      decoration: loginTheme.copyWith(
          labelText: 'Password',
          labelStyle: jakarta.copyWith(fontSize: 14, color: whiteStatic),
          suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              })),
    );
  }

  // -------------- login button --------------

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        userInputCheck();
        // debugPrint('test');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 221, 27)),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
      ),
      child: Text(
        'Log In',
        style: jakarta.copyWith(fontSize: 14, color: Colors.black),
      ),
    );
  }

  // -------------- NRP & password checker --------------

  void userInputCheck() {
    var nrp = int.tryParse(_nrpInput.text);
    String password = _passwordInput.text;
    bool isLoggedIn = false;
    dataMhs.forEach((key, value) {
      if (key == nrp && value['password'] == password) {
        isLoggedIn = true;
      }
    });
    if (isLoggedIn) {
      _login();
      debugPrint('login berhasil');
      return;
    } else {
      errorDialog();
      debugPrint('login tidak berhasil');
    }
  }

  // -------------- message jika user input salah  --------------

  errorDialog() {
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text('Login Gagal',
                  style: jakarta.copyWith(color: black, fontSize: 20)),
              content: SizedBox(
                width: 220,
                height: 37,
                child: Text('Silahkan cek kembali NRP dan Password anda.',
                    style: jakarta.copyWith(fontSize:14, color: black)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: jakarta.copyWith(fontSize:14, color: itsBlue),
                  ),
                )
              ],
            )));
  }

  Widget options() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton(
        onPressed: () {
          debugPrint('tertekan');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResetPassPage()));
        },
        child: Text('Forged Password?',
            style: jakarta.copyWith(fontSize: 11, color: whiteStatic)),
      ),
    );
  }
}