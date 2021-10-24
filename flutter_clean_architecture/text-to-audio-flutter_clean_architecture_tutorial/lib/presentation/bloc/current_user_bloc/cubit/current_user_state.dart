part of 'current_user_cubit.dart';

abstract class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

class CurrentuserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState{}

class CurrentUserLoaded extends CurrentUserState {
  final User currentUser;

  CurrentUserLoaded(this.currentUser);
  @override
  List<Object> get props => [currentUser];
}

class CurrentUserNotSelected extends CurrentUserState{}
