import 'package:firebase_database/firebase_database.dart';

String bannerURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/banner.json';
String appURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/appData.json';
String userURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/user.json';
String announcementURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/announcement.json';
String agendaURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/agenda.json';
String userClassURL =
    'https://myits-mobile-default-rtdb.firebaseio.com/data/userClass.json';

final userRef = FirebaseDatabase.instance.ref().child('data/user');
final agendaRef = FirebaseDatabase.instance.ref().child('data/agenda');
final announcementRef = FirebaseDatabase.instance.ref().child('data/announcement');


