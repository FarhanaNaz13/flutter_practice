import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/presentation/bloc/text/cubit/selected_text_cubit.dart';
import 'package:text_to_audio/utils/string_res.dart';

class CurrentTextChunkWidget extends StatelessWidget {
  const CurrentTextChunkWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedTextCubit, SelectedTextState>(
      builder: (context, SelectedTextState state) {
        switch (state.runtimeType) {
          case SelectedTextLoaded:
            final text = (state as SelectedTextLoaded).textChunk.transcription;
            return Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                      width: 1, color: Theme.of(context).primaryColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: GoogleFonts.raleway(fontSize: 24),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          final scaffoldMessanger =
                              ScaffoldMessenger.of(context);
                          scaffoldMessanger.showSnackBar(
                            SnackBar(
                              content: Text(StringRes
                                  .are_you_sure_you_want_to_record_against_some_other_text_data),
                              action: SnackBarAction(
                                label: StringRes.yes,
                                onPressed: () {
                                  scaffoldMessanger.hideCurrentSnackBar();
                                  //TODO
                                  //fetch new textdata
                                },
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.change_circle_outlined,
                        ),
                      ),
                    )
                  ],
                ));
          case SelectedTextError:
            return Text(StringRes.something_went_wrong);
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
