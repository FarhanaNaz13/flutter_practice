part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}
class UpdateUserSuccess extends UpdateUserState {}
class UpdateUserError extends UpdateUserState {}
class UpdateUserLoading extends UpdateUserState {}
