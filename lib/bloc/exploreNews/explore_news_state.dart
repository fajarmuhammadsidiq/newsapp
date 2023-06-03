part of 'explore_news_bloc.dart';

abstract class ExploreNewsState extends Equatable {
  const ExploreNewsState();

  @override
  List<Object> get props => [];
}

class ExploreNewsStateInitial extends ExploreNewsState {}

class ExploreNewsStateLoading extends ExploreNewsState {}

class ExploreNewsStateCompleted extends ExploreNewsState {
  const ExploreNewsStateCompleted({
    required this.headlines,
  });

  final Headlines headlines;
}

class ExploreNewsStateError extends ExploreNewsState {
  const ExploreNewsStateError({required this.errorMessage});

  final String errorMessage;
}
