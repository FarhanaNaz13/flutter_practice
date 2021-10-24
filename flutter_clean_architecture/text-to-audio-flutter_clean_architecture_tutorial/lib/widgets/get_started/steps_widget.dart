import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({Key? key}) : super(key: key);

  static const _svgs = [
    'assets/registration-form.svg',
    'assets/audio.svg',
    'assets/voice-microphone.svg',
    'assets/cloud-computing.svg',
  ];

  static const _titles = [
    StringRes.form_fill_up,
    StringRes.record_audio,
    StringRes.review_audio,
    StringRes.submit_recording,
  ];
  static const _descs = [
    StringRes.desc_form_fill_up,
    StringRes.desc_record_audio,
    StringRes.desc_review_audio,
    StringRes.desc_submit_recording,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              StringRes.howTo,
              style: GoogleFonts.raleway(fontSize: 32),
            ),
            SizedBox(
              height: 32.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final theme = Theme.of(context);
                return TimelineTile(
                  isFirst: index == 0,
                  isLast: index == _titles.length - 1,
                  beforeLineStyle: LineStyle(
                    color: theme.primaryColor.withOpacity(
                      0.4,
                    ),
                    thickness: 1.0,
                  ),
                  afterLineStyle: LineStyle(
                    color: theme.primaryColor.withOpacity(
                      0.3,
                    ),
                    thickness: 1.0,
                  ),
                  endChild: rightChild(
                    context,
                    _svgs[index],
                    _titles[index],
                    _descs[index],
                  ),
                  indicatorStyle: IndicatorStyle(
                    color: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    indicator: Container(
                      child: Center(child: Text('${index + 1}')),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _titles.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget rightChild(
    BuildContext context,
    String svgPath,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(2.0),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
                width: 54,
                height: 54,
              ),
              SizedBox(
                width: 16.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
