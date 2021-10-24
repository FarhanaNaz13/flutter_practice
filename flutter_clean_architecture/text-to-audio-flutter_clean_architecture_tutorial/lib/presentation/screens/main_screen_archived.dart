import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/get_started/purpose_widget.dart';
import 'package:text_to_audio/presentation/widgets/steps_widget.dart';
import 'package:text_to_audio/utils/string_res.dart';
import 'package:text_to_audio/utils/widget_extentions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _curIdx = 0;
  List<Widget> items = [
    PurposeWidget(),
    StepsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Center(child: items[_curIdx])),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _curIdx == 0
                  ? SizedBox()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          if (_curIdx > 0) {
                            _curIdx--;
                          }
                        });
                      },
                      child: Text(StringRes.prev),
                    ),
              _curIdx == items.length - 1
                  ? SizedBox()
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          if (_curIdx < items.length - 1) {
                            _curIdx++;
                          }
                        });
                      },
                      child: Text(StringRes.next),
                    ),
            ],
          )
        ],
      ),
    ).makethemeScreen(context);
  }
}
