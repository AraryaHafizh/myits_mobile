import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:myits_portal/logic/style.dart';

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
                Text('Enter your myITS ID to find your account.',
                    style: jakarta.copyWith(fontSize: 14, color: whiteStatic)),
                nrpField(),
                options(),
                searchButton(),
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

  // -------------- NRP field --------------

  Widget nrpField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextField(
        cursorColor: itsYellowStatic,
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
      ),
    );
  }

  // -------------- login button --------------

  Widget searchButton() {
    return ElevatedButton(
      onPressed: () {
        wipAlertDialog(context);
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

  // void userInputCheck() {
  //   var nrp = int.tryParse(_nrpInput.text);
  //   String password = _passwordInput.text;
  //   bool isLoggedIn = false;
  //   dataMhs.forEach((key, value) {
  //     if (key == nrp && value['password'] == password) {
  //       isLoggedIn = true;
  //     }
  //   });
  //   if (isLoggedIn) {
  //     // _login();
  //     debugPrint('login berhasil');
  //     return;
  //   } else {
  //     errorDialog();
  //     debugPrint('login tidak berhasil');
  //   }
  // }

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
                    style: jakarta.copyWith(fontSize: 14, color: black)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: jakarta.copyWith(fontSize: 14, color: itsBlue),
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
          Navigator.pop(context);
        },
        child: Text('Back to Login Page',
            style: jakarta.copyWith(fontSize: 11, color: Colors.white)),
      ),
    );
  }
}
