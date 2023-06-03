part of 'explore_news_bloc.dart';

abstract class ExploreNewsEvent extends Equatable {
  const ExploreNewsEvent();

  @override
  List<Object> get props => [];
}

class ApiExploreNewsEvent extends ExploreNewsEvent {}
