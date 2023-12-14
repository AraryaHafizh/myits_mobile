import 'package:flutter/material.dart';
import 'package:myits_portal/ui/login/login_page.dart';
import 'package:myits_portal/logic/style.dart';

class SessionExp extends StatefulWidget {
  const SessionExp({super.key});

  @override
  State<SessionExp> createState() => _LoginPageState();
}

class _LoginPageState extends State<SessionExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: itsBlue,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(':(',
                      style: jakarta.copyWith(
                          fontSize: 48,
                          color: itsYellowStatic,
                          fontWeight: FontWeight.w800)),
                ),
                const SizedBox(height: 15),
                Text('Whoops, your session \nhas expired.',
                    style: jakarta.copyWith(
                        fontSize: 28,
                        color: itsYellowStatic,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Text(
                    'But Don\'t panic, just log back in and pick up where you left off..',
                    style: jakarta.copyWith(
                        fontSize: 14,
                        color: itsYellowStatic,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage(), // Arahkan ke LoginPage
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(itsYellowStatic),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12)),
                  ),
                  child: Text('Login',
                      style:
                          jakarta.copyWith(fontSize: 14, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
