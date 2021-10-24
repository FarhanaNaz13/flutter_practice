part of 'delete_user_cubit.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

class DeleteUserInitial extends DeleteUserState {}
class DeleteUserSuccess extends DeleteUserState {}
class DeleteUserLoading extends DeleteUserState {}
class DeleteUserError extends DeleteUserState {}
