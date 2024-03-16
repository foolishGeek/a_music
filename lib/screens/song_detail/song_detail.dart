import 'package:a_music/controller/song_detail_controller.dart';
import 'package:a_music/resource/constants.dart';
import 'package:a_music/screens/song_detail/music_player.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:a_music/utilities/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class SongDetails extends StatefulWidget {
  final ISongDetailController controller;

  const SongDetails({Key? key, required this.controller})
      : super(key: key);

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {

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
          height: MediaQuery
              .sizeOf(context)
              .height,
          width: MediaQuery
              .sizeOf(context)
              .width,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                            color: AppTheme().theme.primaryTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Center(
                    child: Hero(
                      tag: widget.controller.tag,
                      child: CircleAvatar(
                        radius: 100.0,
                        child: ClipOval(
                          child: Image.network(widget.controller.songDetails.img),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Text(
                      widget.controller.songDetails.title,
                      style: Constants.kTextStyleBold.copyWith(
                          fontSize: 24.0,
                          height: 26 / 24,
                          color: AppTheme().theme.primaryTextColor),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: PlayMusic(controller: widget.controller),
                )
              ],
            ),
          ),
        ));
  }
}
