import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_audio/data/model/user_text_audio.dart';
import 'package:text_to_audio/presentation/bloc/user_text_audio_list/cubit/user_text_audio_list_cubit.dart';
import 'package:text_to_audio/presentation/widgets/user_text_audio/user_text_audio_widget.dart';
import 'package:text_to_audio/utils/string_res.dart';

class UserTextAudioListWidget extends StatefulWidget {
  const UserTextAudioListWidget({Key? key}) : super(key: key);

  @override
  State<UserTextAudioListWidget> createState() =>
      _UserTextAudioListWidgetState();
}

class _UserTextAudioListWidgetState extends State<UserTextAudioListWidget> {
  final _selected = <int>[];

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   BlocProvider.of<UserTextAudioListCubit>(context).getUserTextAudioList();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserTextAudioListCubit, UserTextAudioListState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case UserTextAudioListLoaded:
            final list =
                (state as UserTextAudioListLoaded).list.reversed.toList();
            return list.isEmpty
                ? Text(StringRes.no_items_to_review)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: _buildList(list)),
                      _selected.isNotEmpty
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 16),
                                _buildSelectionControls(list),
                              ],
                            )
                          : SizedBox(),
                    ],
                  );
          case UserTextAudioListError:
            return Text(StringRes.something_went_wrong);
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildList(List<UserTextAudio> list) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return UserTextAudioWidget(
          userTextAudio: list[index],
          isSelected: _selected.contains(index),
          onTap: () {
            setState(() {
              if (_selected.contains(index))
                _selected.remove(index);
              else
                _selected.add(index);
            });
          },
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: list.length,
    );
  }

  Widget _buildSelectionControls(list) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              _selected.length < list.length
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selected.clear();
                              _selected.addAll(
                                  Iterable<int>.generate(list.length).toList());
                            });
                          },
                          child: Text(
                            StringRes.select_all,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(
                          width: 32,
                        ),
                      ],
                    )
                  : SizedBox(),
              GestureDetector(
                onTap: _deselctAll,
                child: Text(
                  StringRes.deselect_all,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: StringRes.items + '('),
                  TextSpan(
                    text: _selected.length.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: ')')
                ]),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      await _deleteSelected(_getSelectedItems(list));
                    },
                    child: Text(
                      StringRes.delete,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _submitSelected(_getSelectedItems(list));
                      _deselctAll();
                      final msngr = ScaffoldMessenger.of(context);
                      msngr.showSnackBar(SnackBar(
                        content: Text(
                          StringRes.submitted_recordings,
                        ),
                        action: SnackBarAction(
                          label: StringRes.ok,
                          onPressed: () {
                            msngr.hideCurrentSnackBar();
                          },
                        ),
                      ));
                    },
                    child: Text(StringRes.submit),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  List<UserTextAudio> _getSelectedItems(List<UserTextAudio> list) {
    final selected = <UserTextAudio>[];
    _selected.forEach((element) {
      selected.add(list[element]);
    });
    return selected;
  }

  _deselctAll() {
    setState(() {
      _selected.clear();
    });
  }

  Future<void> _submitSelected(List<UserTextAudio> list) async {
    final userTextAudioListCubit =
        BlocProvider.of<UserTextAudioListCubit>(context);
    await userTextAudioListCubit.upload(list);
    await userTextAudioListCubit.getUserTextAudioList();
    _deselctAll();
  }

  Future<void> _deleteSelected(List<UserTextAudio> list) async {
    final userTextAudioListCubit =
        BlocProvider.of<UserTextAudioListCubit>(context);
    await userTextAudioListCubit.deleteTextAudioList(list);
    _deselctAll();
    await userTextAudioListCubit.getUserTextAudioList();
  }
}
