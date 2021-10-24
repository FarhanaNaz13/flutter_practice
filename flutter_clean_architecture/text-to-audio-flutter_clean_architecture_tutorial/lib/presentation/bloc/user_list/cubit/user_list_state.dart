part of 'user_list_cubit.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoaded extends UserListState {
  final List<User> userList;

  UserListLoaded(this.userList);

  @override
  List<Object> get props => [userList];
}

class UserListLoading extends UserListState {}

class UserListError extends UserListState {}

class UserListEmpty extends UserListState {}
