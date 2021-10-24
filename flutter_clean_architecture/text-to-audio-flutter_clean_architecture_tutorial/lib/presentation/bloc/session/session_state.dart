part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}

class SessionSuccess extends SessionState {
  final bool isUserLoggedIn;

  SessionSuccess(this.isUserLoggedIn);
  @override
  List<Object> get props => [isUserLoggedIn];
}

class SessionFailure extends SessionState {}

class SessionLoading extends SessionState {}
