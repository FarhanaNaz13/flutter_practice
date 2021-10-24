import 'dart:async';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:text_to_audio/data/model/audio.dart';
import 'package:text_to_audio/utils/string_res.dart';

class AudioRecorder extends StatefulWidget {
  final String path;
  final Function(Audio) onStop;
  final Function() onNextPressed;
  final VoidCallback onStart;

  const AudioRecorder({
    required this.path,
    required this.onStart,
    required this.onStop,
    required this.onNextPressed,
  });

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildRecordStopControl(),
          const SizedBox(width: 20),
          // _buildPauseResumeControl(),
          _buildQuickNextControl(),
          const SizedBox(width: 20),

          _buildText(),
        ],
      ),
    );
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!_isPaused) {
      icon = Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isPaused ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }

    return Text("Waiting to record");
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await Record.hasPermission()) {
        await Record.start(path: widget.path);

        bool isRecording = await Record.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    await Record.stop();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(widget.path)));
    setState(() => _isRecording = false);
    
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await Record.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await Record.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    const tick = const Duration(seconds: 1);

    _timer?.cancel();

    _timer = Timer.periodic(tick, (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  _buildQuickNextControl() {
    return ElevatedButton(
      onPressed: () async {
        await _stop();
        widget.onNextPressed();
      },
      child: Text(StringRes.save_and_record_next),
    );
  }
}
