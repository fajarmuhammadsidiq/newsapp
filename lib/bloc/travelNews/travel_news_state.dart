part of 'travel_news_bloc.dart';

abstract class TravelNewsState extends Equatable {
  const TravelNewsState();

  @override
  List<Object> get props => [];
}

class TravelNewsStateInitial extends TravelNewsState {}

class TravelNewsStateLoading extends TravelNewsState {}

class TravelNewsStateCompleted extends TravelNewsState {
  const TravelNewsStateCompleted({
    required this.headlines,
  });

  final Headlines headlines;
}

class TravelNewsStateEror extends TravelNewsState {
  const TravelNewsStateEror({required this.errorMessage});

  final String errorMessage;
}
