import 'package:a_music/controller/authenticate/authenticate_controller.dart';
import 'package:a_music/resource/constants.dart';
import 'package:a_music/screens/authenticate/login_card.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:a_music/utilities/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AuthenticateUser extends StatefulWidget {
  const AuthenticateUser({Key? key}) : super(key: key);

  @override
  State<AuthenticateUser> createState() => _AuthenticateUserState();
}

class _AuthenticateUserState extends State<AuthenticateUser> {
  final AuthenticationController _controller = AuthenticationController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        onThemeChange: (side) {
          setState(() {});
        },
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        StringConstants.kTitleText,
                        style: Constants.kTextStyleBold.copyWith(
                            color: AppTheme().theme.primaryTextColor,
                            fontSize: 42.0,
                            height: 56 / 42,
                            shadows: <Shadow>[
                              Shadow(
                                  blurRadius: 8.0,
                                  color: AppTheme().theme.primaryTextColor)
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: LottieBuilder.asset(
                        AssetsConstants.kLogInAnimation,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: LoginCard(
                    controller: _controller,
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30.0,
                      ),
                      child: Text(
                        _controller.message.value,
                        textAlign: TextAlign.start,
                        style: Constants.kTextStyleRegular.copyWith(
                            fontSize: 14.0,
                            color: AppTheme().theme.primaryTextColor),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
