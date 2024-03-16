import 'package:a_music/resource/enum.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:a_music/utilities/widgets/toggle.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  final Widget body;
  final Color? backgroundColor;
  final Function(ButtonSide) onThemeChange;

  const BaseWidget(
      {Key? key,
      required this.body,
      this.backgroundColor,
      required this.onThemeChange})
      : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor:
            widget.backgroundColor ?? AppTheme().theme.backgroundColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ThemeToggle(
                onThemeChange: (side) {
                  if (side == ButtonSide.right) {
                    AppTheme().theme = DarkTheme();
                  } else {
                    AppTheme().theme = LightTheme();
                  }
                  widget.onThemeChange(side);
                },
                side: AppTheme().theme is LightTheme
                    ? ButtonSide.left
                    : ButtonSide.right,
              ),
            ),
            widget.body
          ],
        ),
      ),
    );
  }
}
