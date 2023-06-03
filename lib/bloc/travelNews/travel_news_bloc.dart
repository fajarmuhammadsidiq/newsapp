import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/headlines_model.dart';
import '../../resources/api_repository.dart';

part 'travel_news_event.dart';
part 'travel_news_state.dart';

class TravelNewsBloc extends Bloc<TravelNewsEvent, TravelNewsState> {
  final ApiRepository _apiRepository = ApiRepository();
  TravelNewsBloc() : super(TravelNewsStateInitial()) {
    on<TravelNewsEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(TravelNewsStateLoading());
        var headlines = await _apiRepository.fetchTravelNews();
        emit(TravelNewsStateCompleted(headlines: headlines));
      } catch (e) {
        emit(TravelNewsStateEror(errorMessage: "wow"));
      }
    });
  }
}
