import 'dart:async';

import 'package:a_music/controller/song_detail_controller.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayMusic extends StatefulWidget {
  final ISongDetailController controller;

  const PlayMusic({Key? key, required this.controller}) : super(key: key);

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  @override
  void initState() {
    widget.controller.setup();
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: LinearProgressIndicator(
                backgroundColor: AppTheme().theme.primaryTextColor,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppTheme().theme.violetColor),
                value: widget.controller.currentProgress.value,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: InkWell(
                  onTap: () {
                    if (widget.controller.isPlaying.value) {
                      widget.controller.pause();
                    } else {
                      widget.controller.play();
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: AppTheme().theme.primaryTextColor,
                            width: 1)),
                    child: Center(
                      child: Icon(
                        widget.controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 36,
                        color: AppTheme().theme.primaryTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
