import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/user_text_audio/user_text_audio_list.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          child: UserTextAudioListWidget(),
        ),
      ),
    );
  }
}
