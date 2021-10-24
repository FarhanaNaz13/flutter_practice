part of 'set_user_to_update_cubit.dart';

abstract class SetUserToUpdateState extends Equatable {
  const SetUserToUpdateState();

  @override
  List<Object> get props => [];
}

class SetUserToUpdateInitial extends SetUserToUpdateState {}
class SetUserToUpdateLoading extends SetUserToUpdateState {}
class SetUserToUpdateSuccess extends SetUserToUpdateState {}
class SetUserToUpdateError extends SetUserToUpdateState {}
