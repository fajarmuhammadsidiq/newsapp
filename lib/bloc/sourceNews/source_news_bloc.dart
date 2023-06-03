import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/headlines_model.dart';
import '../../page/detailPage/detail_headlines.dart';
import '../../resources/api_repository.dart';

part 'source_news_event.dart';
part 'source_news_state.dart';

class SourceNewsBloc extends Bloc<SourceNewsEvent, SourceNewsState> {
  final ApiRepository _apiRepository = ApiRepository();
  final detailHeadlinesNewsPage detail = detailHeadlinesNewsPage();
  SourceNewsBloc() : super(SourceNewsStateInitial()) {
    on<ApiNewsEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(SourceNewsStateLoading());
        var headlines = await _apiRepository.fetchMoreSource(event.name);
        emit(SourceNewsStateCompleted(headlines: headlines));
      } catch (e) {
        emit(SourceNewsStateError(errorMessage: "wow"));
      }
    });
  }
}
