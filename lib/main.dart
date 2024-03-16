import 'package:a_music/resource/shared_pref.dart';
import 'package:a_music/screens/authenticate/authentication.dart';
import 'package:a_music/screens/songs/explore_songs.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  AppTheme().theme = LightTheme();
  await SharedPref.instance.setUp();
  //This is a dummy check for authentication check
  final isLoggedIn = await SharedPref.instance.isLoggedIn();
  await Firebase.initializeApp();
  runApp(MusicApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MusicApp extends StatelessWidget {
  final bool isLoggedIn;

  const MusicApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'a-music',
      home: isLoggedIn ? const ExploreSongs() : const AuthenticateUser(),
    );
  }
}
