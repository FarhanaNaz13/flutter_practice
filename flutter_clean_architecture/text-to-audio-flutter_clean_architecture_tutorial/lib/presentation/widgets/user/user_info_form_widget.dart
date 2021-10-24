import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:text_to_audio/data/model/signup/signup_request.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/utils/string_res.dart';


class UserInfoFormWidget extends StatefulWidget {
  final SignUpRequest user;
  final GlobalKey<FormState> formKey;
  const UserInfoFormWidget({
    Key? key,
    required this.user,
    required this.formKey,
  }) : super(key: key);

  @override
  State<UserInfoFormWidget> createState() => _UserInfoFormWidgetState();
}

class _UserInfoFormWidgetState extends State<UserInfoFormWidget> {
  late SignUpRequest user;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user.name);
    return Center(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              onChanged: (value) {
                user.name = value;
              },
              decoration: InputDecoration(hintText: StringRes.enter_your_name),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return StringRes.name_cannot_be_empty;
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            FormBuilderDropdown(
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)],
              ),
              name: StringRes.age,
              initialValue: user.age >= 14 ? user.age : null,
              hint: Text(StringRes.enter_your_age),
              items: List<int>.generate(100, (i) => i + 1)
                  .sublist(14)
                  .map(
                    (e) => DropdownMenuItem<int>(
                      value: e,
                      child: Text(e.toString()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  user.age = value as int;
                });
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            FormBuilderDropdown(
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)],
              ),
              initialValue: user.gender.isNotEmpty ? user.gender : null,
              name: StringRes.name,
              hint: Text(StringRes.enter_your_gender),
              items: <String>['MALE', 'FEMALE', 'OTHER']
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e.toString()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  user.gender = value as String;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
