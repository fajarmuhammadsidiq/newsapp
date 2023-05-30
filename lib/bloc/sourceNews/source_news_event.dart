part of 'source_news_bloc.dart';

abstract class SourceNewsEvent extends Equatable {
  const SourceNewsEvent();

  @override
  List<Object> get props => [];
}

class ApiNewsEvent extends SourceNewsEvent {
  const ApiNewsEvent({required this.name});

  final String name;
}
