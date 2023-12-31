import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/logic/provider_handler.dart';
import 'package:myits_portal/logic/style.dart';
import 'package:myits_portal/logic/widgets.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final int nrp;
  const EditProfile({super.key, required this.nrp});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String username = '';
  String email = '';
  String phone = '';
  String password = '';
  TextEditingController usernameInput = TextEditingController();
  TextEditingController dobInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    username = userProvider.getStudData('nama', widget.nrp);
    email = userProvider.getStudData('email', widget.nrp);
    phone = userProvider.getStudData('nomor telepon', widget.nrp);
    password = userProvider.getStudData('password', widget.nrp);
  }

  @override
  void dispose() {
    usernameInput.dispose();
    emailInput.dispose();
    phoneInput.dispose();
    passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarHandler(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: editProfile());
  }

  appBarHandler() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      toolbarHeight: 85,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.onSecondary,
          )),
      title: Text('My Profile',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w700)),
    );
  }

  Widget editProfile() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          children: [
            // Profile avatar
            Center(
              child: CircleAvatar(
                backgroundColor: itsBlue,
                radius: 60,
                child: Stack(children: [
                  Center(
                    child: Text(
                      username[0],
                      style: jakarta.copyWith(fontSize: 75, color: white),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton.filled(
                          onPressed: () {
                            wipAlertDialog(context);
                          },
                          icon: Icon(Icons.edit, color: itsBlue),
                          style: TextButton.styleFrom(backgroundColor: white))),
                ]),
              ),
            ),
            const SizedBox(height: 50),
            Wrap(
              runSpacing: 20,
              children: [
                fieldMaker(
                    true,
                    hintInput: username,
                    usernameInput,
                    hintText: 'Change Name'),
                fieldMaker(
                    false, hintInput: email, emailInput, hintText: email),
                fieldMaker(
                    true,
                    hintInput: phone,
                    phoneInput,
                    hintText: 'Change Phone'),
                fieldMaker(true, passwordInput, hintText: 'Change Password'),
                Center(child: saveButton())
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldMaker(isEnable, controller, {hintText, hintInput}) {
    return TextFormField(
      controller: controller,
      onTap: () {
        controller.text = hintInput;
      },
      enabled: isEnable,
      decoration: profileSetting.copyWith(
        labelText: hintText,
        labelStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
      ),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        pushNewDat(usernameInput.text, phoneInput.text, passwordInput.text);
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 45),
        backgroundColor: itsBlue,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15),
        ),
      ),
      child: Text('Save',
          style: jakarta.copyWith(fontSize: 18, color: Colors.white)),
    );
  }

  void pushNewDat(String name, String phone, String pass) {
    final databaseRef = FirebaseDatabase.instance
        .ref()
        .child('data/user/${widget.nrp}');

    Map<String, dynamic> updatedData = {};

    if (name.isNotEmpty) {
      updatedData['nama'] = name;
    }

    if (phone.isNotEmpty) {
      updatedData['nomor telepon'] = phone;
    }

    if (pass.isNotEmpty) {
      updatedData['password'] = encryptPassword(pass);
    }

    if (updatedData.isNotEmpty) {
      databaseRef.update(updatedData).then((_) {
      }).onError((error, stackTrace) {
        throw ('error: $error');
      });
    } 
    // else {
    //   debugPrint('Tidak ada data untuk diperbarui.');
    // }
  }
}
