import 'package:text_to_audio/utils/string_res.dart';

class Step {
  final String title;
  final String desc;
  final String svg;

  Step(
    this.title,
    this.desc,
    this.svg,
  );
}

final steps = [
  // Step(
  //   StringRes.form_fill_up,
  //   StringRes.desc_form_fill_up,
  //   'assets/registration-form.svg',
  // ),
  Step(
    StringRes.record_audio,
    StringRes.desc_record_audio,
    'assets/voice-microphone.svg',
  ),
  Step(
    StringRes.review_audio,
    StringRes.desc_review_audio,
    'assets/audio.svg',
  ),
  Step(
    StringRes.submit_recording,
    StringRes.desc_submit_recording,
    'assets/cloud-computing.svg',
  ),
];
