part of 'get_user_to_update_cubit.dart';

abstract class GetUserToUpdateState extends Equatable {
  const GetUserToUpdateState();

  @override
  List<Object> get props => [];
}

class GetUserToUpdateInitial extends GetUserToUpdateState {}

class GetUserToUpdateLodaing extends GetUserToUpdateState {}

class GetUserToUpdateSuccess extends GetUserToUpdateState {
  final User user;

  GetUserToUpdateSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class GetUserToUpdateError extends GetUserToUpdateState {}
