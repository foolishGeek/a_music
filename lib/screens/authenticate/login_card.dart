import 'package:a_music/controller/authenticate/authenticate_controller.dart';
import 'package:a_music/controller/authenticate/i_authenticate.dart';
import 'package:a_music/resource/constants.dart';
import 'package:a_music/resource/enum.dart';
import 'package:a_music/screens/songs/explore_songs.dart';
import 'package:a_music/utilities/widgets/toggle_button.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:a_music/utilities/widgets/button_loader.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  final IAuthenticate controller;

  const LoginCard({Key? key, required this.controller}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  late IAuthenticate _controller;
  ButtonSide _currentSide = ButtonSide.left;
  Color _currentColor = AppTheme().theme.cardColor;

  @override
  void initState() {
    //...
    _controller = widget.controller;
    //....

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listenToState();
    });
    super.initState();
  }

  void _listenToState() {
    _controller.uiState.listen((state) {
      if (state == UiState.loading) {
        _buttonController.start();
      } else {
        _buttonController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 5.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          color: _currentColor,
          shadowColor: _currentColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 70.0, bottom: 70.0),
            child: Column(
              children: [
                TextField(
                  key: const Key('email_text_field'),
                  controller: _emailController,
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: Constants.kTextStyleRegular.copyWith(
                      fontSize: 18.0,
                      height: 20 / 18,
                      color: AppTheme().theme.blackColor),
                  cursorColor: AppTheme().theme.blackColor,
                  cursorHeight: 20.0,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    fillColor: AppTheme().theme.blackColor.withOpacity(0.1),
                    filled: true,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0))),
                    hintText: StringConstants.kEnterEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    key: const Key('password_text_field'),
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: Constants.kTextStyleRegular.copyWith(
                        fontSize: 18.0,
                        height: 20 / 18,
                        color: AppTheme().theme.blackColor),
                    cursorColor: AppTheme().theme.blackColor,
                    cursorHeight: 20.0,
                    decoration: InputDecoration(
                      fillColor: AppTheme().theme.blackColor.withOpacity(0.1),
                      filled: true,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(18.0),
                              bottomRight: Radius.circular(18.0))),
                      hintText: StringConstants.kEnterPassword,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionalTranslation(
            translation: const Offset(0.0, -0.1),
            child: ToggleButton(
              bodyColor: AppTheme().theme.backgroundColor,
              borderColor: _currentColor,
              leftWidget: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  StringConstants.kLoginText,
                  style: Constants.kTextStyleBold.copyWith(
                      fontSize: 18.0, color: AppTheme().theme.primaryTextColor),
                ),
              ),
              rightWidget: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  StringConstants.kSignUpText,
                  style: Constants.kTextStyleBold.copyWith(
                      fontSize: 18.0, color: AppTheme().theme.primaryTextColor),
                ),
              ),
              onChange: (side) {
                if (side == ButtonSide.right) {
                  _currentColor = AppTheme().theme.greenColor;
                } else {
                  _currentColor = AppTheme().theme.cardColor;
                }
                _currentSide = side;
                setState(() {});
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 0.0,
          right: 0.0,
          child: RoundedLoadingButton(
            key: const Key('button'),
              controller: _buttonController,
              color: AppTheme().theme.primaryTextColor.withOpacity(0.7),
              onPressed: () async {
                if (_emailFocus.hasFocus) {
                  _emailFocus.unfocus();
                }
                if (_passwordFocus.hasFocus) {
                  _passwordFocus.unfocus();
                }
                bool status = false;
                if (_currentSide == ButtonSide.left) {
                  status = await _controller.signIn(
                      email: _emailController.text,
                      password: _passwordController.text);
                } else {
                  status = await _controller.signUp(
                      email: _emailController.text,
                      password: _passwordController.text);
                }
                if (status) {
                  _reDirect();
                }
              },
              child: Text(
                (_currentSide == ButtonSide.left
                    ? StringConstants.kLoginText
                    : StringConstants.kSignUpText),
                style: Constants.kTextStyleBold.copyWith(
                    fontSize: 20.0,
                    height: 22 / 20,
                    color: AppTheme().theme.backgroundColor),
              )),
        ),
      ],
    );
  }

  void _reDirect() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const ExploreSongs();
    }));
  }
}
