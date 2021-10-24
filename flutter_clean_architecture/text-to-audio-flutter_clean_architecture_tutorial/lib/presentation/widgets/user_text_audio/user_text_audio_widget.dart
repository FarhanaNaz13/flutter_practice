import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/presentation/widgets/audio/audio_listen_control_widget.dart';
import 'package:text_to_audio/presentation/widgets/time_formatter_widge.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';
import 'package:text_to_audio/presentation/widgets/user/user_widget.dart';

class UserTextAudioWidget extends StatelessWidget {
  final UserTextAudio userTextAudio;
  final bool isSelected;
  final Function() onTap;

  const UserTextAudioWidget({
    Key? key,
    required this.userTextAudio,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                userTextAudio.textChunk.transcription,
                style: GoogleFonts.raleway(fontSize: 24),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(userTextAudio.environment)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimeFormatterWidget(
                      duration: userTextAudio.audio.duration.toInt()),
                  SizedBox(
                    width: 16,
                  ),
                  AudioListenControl(isListening: false, onTap: () {}),
                ],
              ),
            ],
          ),
        ],
      ).roundRect(context,
          borderColor: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.1)),
    );
  }
}
