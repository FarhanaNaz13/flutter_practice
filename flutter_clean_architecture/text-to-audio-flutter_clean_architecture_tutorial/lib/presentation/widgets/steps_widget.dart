import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_audio/data/model/step.dart';
import 'package:text_to_audio/presentation/widgets/step_widget.dart';
import 'package:text_to_audio/presentation/widgets/user_text_audio/user_text_audio_list.dart';
import 'package:text_to_audio/presentation/widgets/user_text_audio/user_text_audio_selection_widget.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StepsWidget extends StatefulWidget {
  const StepsWidget({Key? key}) : super(key: key);
  @override
  State<StepsWidget> createState() => _StepsWidgetState();
}

class _StepsWidgetState extends State<StepsWidget> {
  int _expandedIndex = -1; //everything hidden intitially

  late final List<Widget> _expansions;

  @override
  void initState() {
    super.initState();
    _expansions = <Widget>[
      // UserWidgetsHolderWidget(),
      UserTextAudioSelectionWidget(),
      Container(
        child: UserTextAudioListWidget(),
        height: 300,
      ),
      Text('3'),
    ];
  }

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
                  isLast: index == steps.length - 1,
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
                  endChild: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_expandedIndex != index)
                          _expandedIndex = index;
                        else
                          _expandedIndex = -1;
                      });
                    },
                    child: StepWidget(
                      key: Key('step_widget_$index'),
                      context: context,
                      svgPath: steps[index].svg,
                      title: steps[index].title,
                      description: steps[index].desc,
                      isExpanded: _expandedIndex == index,
                      child: _expansions[index],
                    ),
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
              itemCount: steps.length,
            ),
          ],
        ),
      ),
    );
  }
}
