part of 'source_news_bloc.dart';

abstract class SourceNewsState extends Equatable {
  const SourceNewsState();

  @override
  List<Object> get props => [];
}

class SourceNewsStateInitial extends SourceNewsState {}

class SourceNewsStateLoading extends SourceNewsState {}

class SourceNewsStateCompleted extends SourceNewsState {
  const SourceNewsStateCompleted({
    required this.headlines,
  });

  final Headlines headlines;
}

class SourceNewsStateError extends SourceNewsState {
  const SourceNewsStateError({required this.errorMessage});

  final String errorMessage;
}
