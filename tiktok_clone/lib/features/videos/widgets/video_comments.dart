import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/utils/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWritingComment = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    if (_isWritingComment) {
      setState(() {
        _isWritingComment = false;
      });
    }
    FocusScope.of(context).unfocus();
  }

  void _onStartWritingComment() {
    setState(() {
      _isWritingComment = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      child: Scaffold(
        backgroundColor: isDarkMode(context) ? null : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: isDarkMode(context) ? null : Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: Text("304 Comments"),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    top: Sizes.size8,
                    bottom: Sizes.size80 + Sizes.size80,
                    left: Sizes.size16,
                    right: Sizes.size16,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: Sizes.size20,
                          child: Text("승민"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "승민",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: Sizes.size14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gaps.v5,
                              Text(
                                "이 영상 너무 좋아요! 다음 영상도 기대할게요 ㅎㅎ! 이 영상 너무 좋아요! 다음 영상도 기대할게요! 이 영상 너무 좋아요! 다음 영상도 기대할게요!",
                              ),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size20,
                            ),
                            Gaps.v5,
                            Text(
                              "52.2K",
                              style: TextStyle(
                                fontSize: Sizes.size12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: Sizes.size20,
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        child: Text("승민"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size52,
                          child: TextField(
                            onTap: _onStartWritingComment,
                            textInputAction: TextInputAction.newline,
                            expands: true,
                            // expands: true를 사용하려면 minLines와 maxLines를 null로 설정해야 함
                            minLines: null,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Add a comment...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: Sizes.size16,
                                vertical: Sizes.size8,
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(right: Sizes.size14),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: isDarkMode(context)
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                    ),
                                    Gaps.h10,
                                    FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: isDarkMode(context)
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                    ),
                                    Gaps.h10,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: isDarkMode(context)
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                    ),
                                    Gaps.h10,
                                    if (_isWritingComment)
                                      InkWell(
                                        onTap: _stopWriting,
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowUp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              filled: true,
                              fillColor: isDarkMode(context)
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
