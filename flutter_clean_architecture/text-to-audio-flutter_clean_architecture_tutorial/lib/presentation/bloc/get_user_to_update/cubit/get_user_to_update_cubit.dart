import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:text_to_audio/data/model/user.dart';
import 'package:text_to_audio/domain/get_user_to_update.dart';

part 'get_user_to_update_state.dart';

class GetUserToUpdateCubit extends Cubit<GetUserToUpdateState> {
  GetUserToUpdateCubit(this._getUserToUpdateUC)
      : super(GetUserToUpdateInitial());
  final GetUserToUpdateUC _getUserToUpdateUC;
  Future<void> getUser() async {
    emit(GetUserToUpdateLodaing());
    try {
      final user = await _getUserToUpdateUC();
      emit(GetUserToUpdateSuccess(user));
    } catch (_) {
      emit(GetUserToUpdateError());
    }
  }
}
