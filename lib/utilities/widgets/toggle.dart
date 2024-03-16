import 'package:a_music/resource/enum.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class ThemeToggle extends StatefulWidget {
  final Function(ButtonSide) onThemeChange;
  final ButtonSide side;

  const ThemeToggle({Key? key, required this.onThemeChange, required this.side})
      : super(key: key);

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  ButtonSide _currentTheme = ButtonSide.left;
  final Duration _animationDuration = const Duration(microseconds: 300);

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.side;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (_currentTheme == ButtonSide.left) {
          _currentTheme = ButtonSide.right;
        } else {
          _currentTheme = ButtonSide.left;
        }
        widget.onThemeChange(_currentTheme);
        setState(() {});
      },
      child: Container(
        height: 30,
        width: 60,
        margin: const EdgeInsets.only(top: 20.0, right: 20.0),
        decoration: BoxDecoration(
            color: AppTheme().theme.violetColor,
            boxShadow: [
              BoxShadow(
                color: AppTheme().theme.violetColor,
                spreadRadius: 2,
                blurRadius: 15,
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15.0))),
        child: AnimatedAlign(
          duration: _animationDuration,
          curve: Curves.easeOut,
          alignment: _currentTheme == ButtonSide.left
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.all(2.0),
            height: 28,
            width: 28,
            decoration: BoxDecoration(
                color: AppTheme().theme.backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(14.0))),
            child: Icon(
              _currentTheme == ButtonSide.left
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode,
              size: 18.0,
              color: AppTheme().theme.primaryTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
