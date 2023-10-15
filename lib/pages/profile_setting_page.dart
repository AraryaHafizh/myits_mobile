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

  @override
  void initState() {
    super.initState();
    username = getStudData('nama', widget.nrp);
    email = getStudData('email', widget.nrp);
    phone = getStudData('nomor telepon', widget.nrp);
    password = getStudData('password', widget.nrp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarHandler(),
        backgroundColor: defaultBG,
        body: SingleChildScrollView(
          child: Column(
            children: [
              editProfile(),
            ],
          ),
        ));
  }

  appBarHandler() {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: defaultBG,
      toolbarHeight: 85,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: black,
          )),
      title: Text(
        'My Profile',
        style: jakarta.copyWith(fontSize: 25, color: black),
      ),
    );
  }

  Widget editProfile() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Column(
        children: [
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
                        onPressed: () {},
                        icon: Icon(Icons.edit, color: itsBlue),
                        style: TextButton.styleFrom(backgroundColor: white))),
              ]),
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            runSpacing: 20,
            children: [
              fieldMaker(true, username, hintText: 'Change Name'),
              fieldMaker(false, '17 Agustus 2000'),
              fieldMaker(true, email, hintText: 'Change Email'),
              fieldMaker(true, phone, hintText: 'New Phone Number'),
              fieldMaker(true, 'Password', hintText: 'Change Password'),
              Center(child: saveButton())
            ],
          ),
        ],
      ),
    );
  }

  Widget fieldMaker(isEnable, label, {hintText}) {
    return TextFormField(
      enabled: isEnable,
      decoration: profileSetting.copyWith(
        labelText: label,
        labelStyle: jakarta.copyWith(fontSize: 16, color: black38),
        hintText: hintText,
        hintStyle: jakarta.copyWith(fontSize: 14, color: black38),
      ),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: () {
        print('save profile!');
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
      child: Text('Save', style: jakarta.copyWith(fontSize: 14, color: Colors.white)),
    );
  }
}
