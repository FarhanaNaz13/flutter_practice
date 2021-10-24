import 'package:flutter/material.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/presentation/widgets/user/user_widget.dart';

class UserFunctionWidget extends StatelessWidget {
  final User user;
  final Function()? onDeletePressed;
  final Function()? onEditPressed;
  final Function()? onChangePressed;

  const UserFunctionWidget({
    Key? key,
    required this.user,
    this.onDeletePressed,
    this.onEditPressed,
    this.onChangePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserWidget(user: user),
          Row(
            children: [
              onEditPressed != null
                  ? IconButton(
                      onPressed: onEditPressed,
                      icon: Icon(Icons.edit),
                    )
                  : SizedBox(),
              SizedBox(
                width: 16.0,
              ),
              onDeletePressed != null
                  ? IconButton(
                      onPressed: onDeletePressed,
                      icon: Icon(Icons.delete),
                    )
                  : SizedBox(),
              SizedBox(
                width: 16.0,
              ),
              onChangePressed != null
                  ? IconButton(
                      onPressed: onChangePressed,
                      icon: Icon(Icons.change_circle_outlined),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
