import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/headlines_model.dart';
import '../../resources/api_repository.dart';

part 'explore_news_event.dart';
part 'explore_news_state.dart';

class ExploreNewsBloc extends Bloc<ExploreNewsEvent, ExploreNewsState> {
  ExploreNewsBloc() : super(ExploreNewsStateInitial()) {
    final ApiRepository _apiRepository = ApiRepository();
    on<ApiExploreNewsEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(ExploreNewsStateLoading());
        var headlines = await _apiRepository.fetchExploreNews();
        emit(ExploreNewsStateCompleted(headlines: headlines));
      } catch (e) {
        emit(const ExploreNewsStateError(errorMessage: "wow"));
      }
    });
  }
}
