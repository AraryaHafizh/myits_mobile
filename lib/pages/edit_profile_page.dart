import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myits_portal/settings/style.dart';
import 'package:myits_portal/settings/controls.dart';

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
    username = getStudData('nama', widget.nrp);
    email = getStudData('email', widget.nrp);
    phone = getStudData('nomor telepon', widget.nrp);
    password = getStudData('password', widget.nrp);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   alertDialog();
    // });
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
      title: Text('My Profile', style: Theme.of(context).textTheme.titleLarge),
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
                            alertDialog();
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
                fieldMaker(true, username, usernameInput,
                    hintText: 'Change Name'),
                fieldMaker(false, email, emailInput, hintText: email),
                fieldMaker(true, phone, phoneInput, hintText: 'Change Phone'),
                fieldMaker(true, password, passwordInput,
                    hintText: 'Change Password'),
                Center(child: saveButton())
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldMaker(isEnable, label, controller, {hintText}) {
    return TextFormField(
      controller: controller,
      onTap: () {
        controller.text = label;
      },
      enabled: isEnable,
      decoration: profileSetting.copyWith(
        labelText: hintText,
        labelStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
        // hintText: hintText,
        // hintStyle:
        //     Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
      ),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        pushNewDat(usernameInput.text, phoneInput.text, passwordInput.text);
        print('profile saved!');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: itsBlue,
        elevation: 5,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 45),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Atur radius sesuai kebutuhan
        ),
      ),
      child: Text('Save',
          style: jakarta.copyWith(fontSize: 14, color: Colors.white)),
    );
  }

  void pushNewDat(String name, String phone, String pass) {
    final databaseRef = FirebaseDatabase.instance
        .ref()
        .child('data/-NhUGJMvu4UZGRNXOBv6/${widget.nrp}');

    Map<String, dynamic> updatedData = {};

    if (name.isNotEmpty) {
      updatedData['nama'] = name;
    }

    if (phone.isNotEmpty) {
      updatedData['nomor telepon'] = phone;
    }

    if (pass.isNotEmpty) {
      updatedData['password'] = pass;
    }

    if (updatedData.isNotEmpty) {
      databaseRef.update(updatedData).then((_) {
        print('Profile saved!');
      }).onError((error, stackTrace) {
        print('Error: $error');
      });
    } else {
      print('Tidak ada data untuk diperbarui.');
    }
  }

  void alertDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Work In Progress',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 23),
            ),
            content: Text(
                'We\'re currently working on this feature. Please hang tight and stay tuned for the exciting updates!.',
                style: Theme.of(context).textTheme.bodySmall),
            actions: [
              // TextButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //       Navigator.pop(context);
              //     },
              //     child: Text('Go Back')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }
}
