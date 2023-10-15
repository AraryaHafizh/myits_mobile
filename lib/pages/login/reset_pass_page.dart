import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myits_portal/settings/controls.dart';
import 'package:myits_portal/data/data_mhs.dart';
import 'package:myits_portal/settings/style.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ResetPassPage> {
  final TextEditingController _nrpInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

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
            const SizedBox(height: 12),
            Text('Enter your myITS ID to find your account.',
                style: jakarta.copyWith(fontSize: 14, color: whiteStatic)),
            const SizedBox(height: 32),
            nrpField(),
            options(),
            searchButton(),
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
        labelText: 'myITS ID',
        labelStyle: jakarta.copyWith(fontSize: 14, color: whiteStatic),
      ),
    );
  }

  // -------------- login button --------------

  Widget searchButton() {
    return ElevatedButton(
      onPressed: () {
        // userInputCheck();
        // debugPrint('test');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 255, 221, 27)),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 22, vertical: 12)),
      ),
      child: Text(
        'Search',
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
      // _login();
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
          Navigator.pop(context);
        },
        child: Text('Back to Login Page',
            style: jakarta.copyWith(fontSize: 11, color: Colors.white)),
      ),
    );
  }
}
