part of 'travel_news_bloc.dart';

abstract class TravelNewsEvent extends Equatable {
  const TravelNewsEvent();

  @override
  List<Object> get props => [];
}

class ApiEventTravel extends TravelNewsEvent {}
