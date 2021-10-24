part of 'selected_text_cubit.dart';

abstract class SelectedTextState extends Equatable {
  const SelectedTextState();

  @override
  List<Object> get props => [];
}

class SelectedTextInitial extends SelectedTextState {}

class SelectedTextLoaded extends SelectedTextState {
  final TextChunk textChunk;

  SelectedTextLoaded(this.textChunk);
  @override
  List<Object> get props => [textChunk];
}


class SelectedTextError extends SelectedTextState {}

class SelectedTextLoading extends SelectedTextState {}
