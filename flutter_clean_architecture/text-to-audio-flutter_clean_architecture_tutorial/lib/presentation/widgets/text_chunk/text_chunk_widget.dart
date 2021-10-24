import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/data/model/text_chunk/text_chunk.dart';
import 'package:text_to_audio/utils/string_res.dart';

class TextChunkWidget extends StatelessWidget {
  final TextChunk textChunk;
  const TextChunkWidget({Key? key, required this.textChunk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        textChunk.transcription,
        style: GoogleFonts.raleway(fontSize: 24),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
