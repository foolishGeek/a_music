import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class Constants {
  static var kTextStyleRegular = GoogleFonts.lato(fontWeight: FontWeight.w400);
  static var kTextStyleBold = GoogleFonts.sen(fontWeight: FontWeight.w600);
  static var kTextStyle500 = GoogleFonts.sen(fontWeight: FontWeight.w500);
}

class StringConstants {
  static const kEnterEmail = "Please enter your email";
  static const kEnterPassword = "Please enter your password";
  static const kTitleText = "Amusing\nA-Music";
  static const kLoginText = "Log In";
  static const kSignUpText = "Sign Up";
  static const kSignInMessage = "Great, Please wait...";
  static const kSongUrl = "https://musicapi.x007.workers.dev/fetch?id=";
  static const kFavKey = "songs";
  static const kFavLocalDbKey = "songs_local";
}

class AssetsConstants {
  static const kLogInAnimation = "assets/animation/sign_in.json";
}
