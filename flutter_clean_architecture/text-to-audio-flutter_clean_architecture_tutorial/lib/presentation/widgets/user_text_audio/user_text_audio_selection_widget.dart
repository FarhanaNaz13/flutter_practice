import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/presentation/bloc/current_audio_bloc/cubit/current_audio_cubit.dart';
import 'package:text_to_audio/presentation/bloc/current_user_bloc/cubit/current_user_cubit.dart';
import 'package:text_to_audio/presentation/bloc/current_user_text_audio/cubit/current_user_text_audio_cubit.dart';
import 'package:text_to_audio/presentation/bloc/text/cubit/selected_text_cubit.dart';
import 'package:text_to_audio/presentation/bloc/user_text_audio_list/cubit/user_text_audio_list_cubit.dart';
import 'package:text_to_audio/presentation/widgets/audio/audio_listen_control_widget.dart';
import 'package:text_to_audio/presentation/widgets/audio/audio_record_control_widget.dart';
import 'package:text_to_audio/presentation/widgets/text_chunk/current_text_chunk_widget.dart';
import 'package:text_to_audio/presentation/widgets/time_formatter_widge.dart';
import 'package:text_to_audio/presentation/widgets/user/current_user_widget.dart';
import 'package:text_to_audio/utils/app_directory.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'dart:async';
import 'dart:io';
import 'package:record/record.dart';
import 'package:text_to_audio/data/model/audio.dart';

import 'package:just_audio/just_audio.dart' as ap;

class UserTextAudioSelectionWidget extends StatefulWidget {
  const UserTextAudioSelectionWidget({Key? key}) : super(key: key);

  @override
  State<UserTextAudioSelectionWidget> createState() =>
      _UserTextAudioSelectionWidgetState();
}

class _UserTextAudioSelectionWidgetState
    extends State<UserTextAudioSelectionWidget> {
  bool _isRecording = false;
  bool _isListening = false;
  int _recordDuration = 0;
  int _playDuration = 0;
  String _enviroment = '';

  final _formKey = GlobalKey<FormState>();
  Timer? _timer;
  late String _path;
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;

  @override
  void dispose() {
    _timer?.cancel();
    _playerStateChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await _stopListening();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormBuilderDropdown(
            validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(context)],
            ),
            name: StringRes.name,
            hint: Text(
              StringRes.enter_recording_environment,
              style: GoogleFonts.raleway(),
            ),
            items: <String>['INDOOR', 'OUTDOOR']
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e.toString()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _enviroment = value as String;
              });
            },
          ),
          SizedBox(height: 56),
          Text(
            StringRes.read_this_text_loudly_nd_clearly,
            style: GoogleFonts.raleway().copyWith(),
          ),
          SizedBox(height: 16),
          CurrentTextChunkWidget(),
          SizedBox(height: 56),
          _buildAudioControl(),
        ],
      ),
    );
  }

  _setNewPath() async {
    final path = await getPathForNewAudioFile();
    setState(() {
      _path = path;
    });
  }

  Widget _buildClockText() {
    if (!_isListening) {
      if (_isRecording) {
        return TimeFormatterWidget(duration: _recordDuration);
      }
      return _recordDuration == 0
          ? Text("Waiting to record")
          : TimeFormatterWidget(duration: _recordDuration);
    } else
      return TimeFormatterWidget(duration: _playDuration);
  }

  Future<void> _startRecording() async {
    final shouldStart =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (!shouldStart) return;
    final currentAudioBloc = BlocProvider.of<CurrentAudioCubit>(context);
    await currentAudioBloc.deleteCurrentAudio();
    if (_isListening) {
      await _stopListening();
    }
    try {
      if (await Record.hasPermission()) {
        await _setNewPath();
        await Record.start(path: _path);
        bool isRecording = await Record.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer(() => setState(() => _recordDuration++));
      }
    } catch (e) {
      print(e);
    }
  }

  Future _stopRecording() async {
    _timer?.cancel();
    await Record.stop();

    setState(() => _isRecording = false);
    final audio = Audio(
      dateCreated: DateTime.now().millisecondsSinceEpoch,
      name: _path.split('/').last,
      duration: _recordDuration,
      fileSize: await File(_path).length(),
      location: _path,
    );
    //set current audio
    final currentAudioBloc = BlocProvider.of<CurrentAudioCubit>(context);
    await currentAudioBloc.setCurrentAudio(audio);
    await currentAudioBloc.getCurrentAudio();
  }

  void _startTimer(Function() fn) {
    const tick = const Duration(seconds: 1);

    _timer?.cancel();

    _timer = Timer.periodic(tick, (Timer t) {
      fn();
    });
  }

  Widget _buildAudioControl() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AudioRecordControlWidget(
                isRecording: _isRecording,
                onTap: () {
                  _isRecording ? _stopRecording() : _startRecording();
                },
              ),
              const SizedBox(width: 20),
              // _buildPauseResumeControl(),

              _buildClockText(),
              const SizedBox(width: 20),
              // _buildPauseResumeControl(),
              AudioListenControl(
                isListening: _isListening,
                onTap: () async {
                  _isListening ? _stopListening() : _startListening();
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSaveControl(),
                SizedBox(width: 16),
                _buildRecordNextControl(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _stopListening() async {
    _timer?.cancel();
    await _audioPlayer.stop();
    await _audioPlayer.seek(const Duration(milliseconds: 0));
    setState(() {
      _isListening = false;
      _playDuration = 0;
    });
  }

  Future<void> _startListening() async {
    if (_recordDuration > 0) {
      if (_isRecording) {
        await _stopRecording();

        //TODO
        //set current audio
      }
    } else {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(StringRes.record_a_clip_to_listen_to_it),
        action: SnackBarAction(
          label: StringRes.ok,
          onPressed: scaffoldMessenger.hideCurrentSnackBar,
        ),
      ));
      return;
    }

    setState(() {
      _isListening = true;
      _playDuration = 0;
    });

    _startTimer(() {
      setState(() {
        if (_playDuration < _recordDuration)
          _playDuration++;
        else
          _stopListening();
      });
    });

    await _audioPlayer.setFilePath(_path);
    await _audioPlayer.play();
  }

  Widget _buildRecordNextControl() {
    return ElevatedButton(
      onPressed: () async {
        await _saveAudio();
        if (_recordDuration != 0) {
          setState(() {
            _isRecording = false;
            _recordDuration = 0;
          });
          await _startRecording();
        }
      },
      child: Text(StringRes.save_and_record_next),
    );
  }

  Widget _buildSaveControl() {
    return ElevatedButton(
      onPressed: () async {
        await _saveAudio();
        setState(() {
          _isRecording = false;
          _recordDuration = 0;
        });
      },
      child: Text(StringRes.save),
    );
  }

  Future<void> _saveAudio() async {
    if (_recordDuration == 0) {
      _showStartRecordMessage();
      return;
    }
    await _stopRecording();

    //store current user, text, audio
    await BlocProvider.of<CurrentUserTextAudioCubit>(context)
        .storeCurrentUserTextAudio(_enviroment);
    //clear cached audio
    final currentAudioBloc = BlocProvider.of<CurrentAudioCubit>(context);
    await currentAudioBloc.clearCurrentAudio();
    await currentAudioBloc.getCurrentAudio();
    final selectedtextCubit = BlocProvider.of<SelectedTextCubit>(context);
    await selectedtextCubit.updateSelectedText();
    await selectedtextCubit.getSelectedTextChunk();

    _showClipSavedMessage();
  }

  void _showStartRecordMessage() {
    final msngr = ScaffoldMessenger.of(context);
    msngr.showSnackBar(SnackBar(
        content: Text(StringRes
            .first_record_audio_and_then_press_to_save_it_and_rec_next_audio)));
  }

  void _showClipSavedMessage() {
    final msngr = ScaffoldMessenger.of(context);
    msngr.showSnackBar(
      SnackBar(
        content: Text(StringRes.clip_saved),
        action: SnackBarAction(
          label: StringRes.view_in_gallery,
          onPressed: () async {
            if (_isRecording) await _stopRecording();
            if (_isListening) await _stopListening();
            await BlocProvider.of<UserTextAudioListCubit>(context)
                .getUserTextAudioList();
            Navigator.pushNamed(context, AppRoute.review_route);
          },
        ),
      ),
    );
  }
}
