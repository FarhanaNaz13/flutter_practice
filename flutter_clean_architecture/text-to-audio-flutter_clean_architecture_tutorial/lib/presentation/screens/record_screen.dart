import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/presentation/bloc/user_text_audio_list/cubit/user_text_audio_list_cubit.dart';
import 'package:text_to_audio/presentation/widgets/navidagtion_drawer.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';
import 'package:text_to_audio/presentation/widgets/user_text_audio/user_text_audio_selection_widget.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text(
            StringRes.asr_data_collection,
            style: GoogleFonts.raleway().copyWith(color: Colors.black),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
          onPressed: () {
            final state = scaffoldKey.currentState;
            if (state == null) return;
            state.isDrawerOpen ? Navigator.pop(context) : state.openDrawer();
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await BlocProvider.of<UserTextAudioListCubit>(context)
                  .getUserTextAudioList();
              Navigator.pushNamed(context, AppRoute.review_route);
            },
            child: Row(
              children: [
                Icon(Icons.audiotrack_outlined),
                Text(StringRes.gallery)
              ],
            ),
          )
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: UserTextAudioSelectionWidget()),
        ),
      ),
    );
  }
}
