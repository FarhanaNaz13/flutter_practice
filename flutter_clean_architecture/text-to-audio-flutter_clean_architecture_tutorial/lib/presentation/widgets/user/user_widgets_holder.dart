import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/widgets/user/sign_up_widget.dart';
import 'package:text_to_audio/presentation/widgets/user/create_user_quick_access_widget.dart';
import 'package:text_to_audio/presentation/widgets/user/update_profile_widget.dart';
import 'package:text_to_audio/presentation/widgets/user/user_list_widget.dart';
import 'package:text_to_audio/utils/app_route.dart';
import 'package:text_to_audio/utils/string_res.dart';

class UserWidgetsHolderWidget extends StatefulWidget {
  final int index;
  const UserWidgetsHolderWidget({Key? key, this.index = 0}) : super(key: key);

  @override
  _UserWidgetsHolderWidgetState createState() =>
      _UserWidgetsHolderWidgetState();
}

class _UserWidgetsHolderWidgetState extends State<UserWidgetsHolderWidget> {
  late int _curIdx;
  late final List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = <Widget>[
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CreateUserQuickAccessWidget(onAddUserPressed: onAddUserPressed),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.review_route);
                },
                child: Text(StringRes.gallery),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 1,
            color: Colors.grey[400],
          ),
          SizedBox(
            height: 8,
          ),
          UserListWidget(
            onUpdateUserPressed: onUpdateUserPressed,
            onUserTapped: onUserTapped,
          ),
        ],
      ),
      Center(
        child: SignUpWidget(
          onCreateUserSuccess: onCreateUserSuccess,
          onCancelPressed: onCancelPressed,
        ),
      ),
      UpdateProfileWidget(
        onUpdateUserSuccess: onUpdateUserSuccess,
        onCancelPressed: onCancelPressed,
      )
    ];

    _curIdx = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return items[_curIdx];
  }

  onAddUserPressed() {
    setState(() {
      _curIdx = 1;
    });
  }

  onCreateUserSuccess() {
    // setState(() {
    //   // _curIdx = 0;
    // });

      Navigator.pushNamed(context, AppRoute.record_route);
  }

  onCancelPressed() {
    setState(() {
      if (widget.index != 0)
        Navigator.pop(context);
      else
        _curIdx = 0;
    });
  }

  onUpdateUserPressed() {
    setState(() {
      _curIdx = 2;
    });
  }

  onUserTapped() {
    setState(() {
      Navigator.pushNamed(context, AppRoute.record_route);
      // _curIdx = 0;
    });
  }

  onUpdateUserSuccess() {
    setState(() {
      _curIdx = 0;
    });
  }
}
