import 'package:a_music/controller/explore/explore_controller.dart';
import 'package:a_music/controller/song_detail_controller.dart';
import 'package:a_music/resource/constants.dart';
import 'package:a_music/resource/enum.dart';
import 'package:a_music/screens/song_detail/song_detail.dart';
import 'package:a_music/utilities/theme/theme_colors.dart';
import 'package:a_music/utilities/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class ExploreSongs extends StatefulWidget {
  const ExploreSongs({Key? key}) : super(key: key);

  @override
  State<ExploreSongs> createState() => _ExploreSongsState();
}

class _ExploreSongsState extends State<ExploreSongs> {
  final IExploreSong _controller = ExploreSongController();
  late TextStyle _songTextStyle;

  @override
  void initState() {
    super.initState();
    _controller.fetchAllSong();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _songTextStyle = Constants.kTextStyleRegular.copyWith(
        fontSize: 16.0,
        height: 18 / 16,
        color: AppTheme().theme.primaryTextColor);
    return BaseWidget(
      onThemeChange: (side) {
        setState(() {});
      },
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
          child: Obx(() => _controller.uiState.value == UiState.loading
              ? Center(
                  child: Lottie.asset("assets/animation/loader.json"),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        "Explore Songs",
                        style: Constants.kTextStyleBold.copyWith(
                            fontSize: 28.0,
                            height: 18 / 16,
                            color: AppTheme().theme.primaryTextColor,
                            shadows: <Shadow>[
                              Shadow(
                                  blurRadius: 4.0,
                                  color: AppTheme().theme.primaryTextColor)
                            ]),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: _controller.songList.songList?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: InkWell(
                                  onTap: () async {
                                    _redirectToDetailsPage(context, index);
                                  },
                                  child: SizedBox(
                                    height: 80.0,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8.0, bottom: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: index % 2 == 0
                                              ? AppTheme()
                                                  .theme
                                                  .cardColor
                                                  .withOpacity(0.2)
                                              : AppTheme()
                                                  .theme
                                                  .orangeColor
                                                  .withOpacity(0.2)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 32.0,
                                            backgroundColor: AppTheme()
                                                .theme
                                                .primaryTextColor,
                                            child: Hero(
                                              tag: index.toString(),
                                              child: CircleAvatar(
                                                radius: 30.0,
                                                backgroundColor: AppTheme()
                                                    .theme
                                                    .backgroundColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      _controller.songList
                                                          .songList![index].img,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: SizedBox(
                                              height: 40,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.5,
                                              child: _willTextOverflow(
                                                      text: _controller
                                                          .songList
                                                          .songList![index]
                                                          .title,
                                                      style: _songTextStyle,
                                                      maxWidth:
                                                          MediaQuery.sizeOf(
                                                                      context)
                                                                  .width *
                                                              0.5)
                                                  ? Marquee(
                                                      text: _controller
                                                          .songList
                                                          .songList![index]
                                                          .title,
                                                      style: _songTextStyle,
                                                      scrollAxis:
                                                          Axis.horizontal,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      blankSpace: 20.0,
                                                      velocity: 100.0,
                                                      pauseAfterRound:
                                                          const Duration(
                                                              seconds: 1),
                                                      startPadding: 10.0,
                                                      accelerationDuration:
                                                          const Duration(
                                                              seconds: 1),
                                                      accelerationCurve:
                                                          Curves.linear,
                                                      decelerationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      decelerationCurve:
                                                          Curves.easeOut,
                                                    )
                                                  : Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _controller
                                                              .songList
                                                              .songList![index]
                                                              .title,
                                                          style: _songTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              final res = await _controller
                                                  .addFav(index);
                                              if (res) {
                                                setState(() {});
                                              }
                                            },
                                            child: Icon(
                                              _controller.isFav(index)
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_outline_rounded,
                                              size: 36,
                                              color: AppTheme()
                                                  .theme
                                                  .primaryTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }))
                  ],
                )),
        ),
      ),
    );
  }

  _redirectToDetailsPage(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SongDetails(
        controller: SongDetailsController(
            tag: index.toString(),
            songDetails: _controller.songList.songList![index]),
      );
    })).then((value) async {
      setState(() {});
    });
  }

  bool _willTextOverflow(
      {required String text,
      required TextStyle style,
      required double maxWidth}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);

    return textPainter.didExceedMaxLines;
  }
}
