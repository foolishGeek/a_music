import 'package:a_music/resource/enum.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final Color borderColor;
  final Color bodyColor;
  final ButtonSide initialSide;
  final Widget leftWidget;
  final Widget rightWidget;
  final Function(ButtonSide) onChange;

  const ToggleButton(
      {Key? key,
      required this.borderColor,
      required this.bodyColor,
      this.initialSide = ButtonSide.left,
      required this.leftWidget,
      required this.onChange,
      required this.rightWidget})
      : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  final animationDuration = const Duration(milliseconds: 200);
  ButtonSide _currentState = ButtonSide.left;

  @override
  void initState() {
    super.initState();
    _currentState = widget.initialSide;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_currentState == ButtonSide.left) {
            _currentState = ButtonSide.right;
          } else {
            _currentState = ButtonSide.left;
          }
        });
        widget.onChange(_currentState);
      },
      child: Container(
        height: 60.0,
        width: 200.0,
        decoration: BoxDecoration(
          color: widget.bodyColor,
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          border: Border.all(width: 2, color: widget.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppTheme().theme.backgroundColor,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: animationDuration,
              curve: Curves.linearToEaseOut,
              alignment: _currentState == ButtonSide.left
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 100.0,
                decoration: BoxDecoration(
                    color: widget.borderColor,
                    borderRadius: _currentState == ButtonSide.left
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0))
                        : const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: widget.leftWidget), Expanded(child: widget.rightWidget)],
            )
          ],
        ),
      ),
    );
  }
}
